# frozen_string_literal: true

class TaipeiVolunteerParser
  SOURCE_TYPE = 'cv101.gov.taipei'
  WEB_URL = 'https://cv101.gov.taipei/Announcement/index.aspx'

  attr_reader :data

  def initialize
    @b = Capybara::Session.new(:selenium_chrome)
    @data = []
  end

  def parse
    @b.visit(WEB_URL)
    # 首頁會是全部的公告，所以要多按召募公告的 tab
    @b.find('#ctl00_ContentPlaceHolder1_divjoinus > ul > li:nth-child(5) > a > span.tit').click
    # 一直按下一頁，直到最後一頁
    while @b.has_css?('input[name="btn_NextPage"][value="下一頁"]')
      parse_all_articles
      input_element = @b.find('input[name="btn_NextPage"][value="下一頁"]')
      input_element.click
    end
    parse_all_articles
    data
  end

  private

  def parse_all_articles
    @b.all('#ctl00_ContentPlaceHolder1_dlReply tbody tbody tr').each do |row|
      data.push({
                  name: row.find('span.tit').text,
                  link: row.find('a')['href'],
                  img_url: 'https://www-ws.gov.taipei/001/Upload/297/relpic/10140/8149584/932809c4-809c-40aa-9f26-ff8d956f764b.jpg',
                  source_type: SOURCE_TYPE
                })
    end
  end
end
