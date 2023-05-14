# frozen_string_literal: true

require_relative 'base_parser'

class TaipeiVolunteerParser < BaseParser
  SOURCE_TYPE = 'cv101.gov.taipei'
  WEB_URL = 'https://cv101.gov.taipei/Announcement/index.aspx'
  attr_reader :b

  private

  def init_parser
    @b = Capybara.current_session
    b.visit(WEB_URL)
    # 首頁會是全部的公告，所以要多按召募公告的 tab
    b.find('#ctl00_ContentPlaceHolder1_divjoinus > ul > li:nth-child(5) > a > span.tit').click
  end

  def pages
    node = b.find('#btn_LastPage')
    onclick_value = node['onclick']
    last_page_number = onclick_value.match(/__doPostBack.*'\d+'/)[0].scan(/\d+/).last.to_i
    [*0...last_page_number]
  end

  def parse_articles(page)
    # 第一頁直接爬，不用按下一頁
    press_next_page! unless page.zero?
    b.all('#ctl00_ContentPlaceHolder1_dlReply tbody tbody tr')
  end

  def parse_article(article)
    {
      name: article.find('span.tit').text,
      link: article.find('a')['href'],
      img_url: 'https://www-ws.gov.taipei/001/Upload/297/relpic/10140/8149584/932809c4-809c-40aa-9f26-ff8d956f764b.jpg',
      source_type: SOURCE_TYPE
    }
  end

  def press_next_page!
    # 一直按下一頁，直到最後一頁
    return unless b.has_css?('input[name="btn_NextPage"][value="下一頁"]')

    input_element = b.find('input[name="btn_NextPage"][value="下一頁"]')
    input_element.click
  end
end
