# frozen_string_literal: true

require_relative 'base_parser'

class SafeParser < BaseParser
  SOURCE_TYPE = 'www.safe.org.tw'
  WEB_URL = 'https://www.safe.org.tw/volunteer/'

  private

  def pages
    [WEB_URL]
  end

  def parse_articles(page)
    doc = Nokogiri::HTML(Faraday.get(WEB_URL).body)
    doc.css('.volunteerList .volunteerItem')
  end

  def parse_article(article)
    img_url = article.at_css('.Img img')&.[]('src')
    name = article.at_css('.title a')&.text&.strip
    organizer = article.at_css('.classTitle')&.text
    event_type = article.at_css('.category')&.text
    working_type = article.at_css('.workingType')&.text
    bonus = article.at_css('.bonus')&.text
    viewer = article.at_css('.viewer')&.text
    remark = article.at_css('.remark')&.text
    deadline = article.at_css('.deadline')&.text
    link = article.at_css('.title a')&.[]('href')
    source_type = SOURCE_TYPE

    detail_doc = Nokogiri::HTML(Faraday.get('https://www.safe.org.tw/volunteer-detail/55__6/').body)
    location = /服務地點:\s*(.*)/.match(detail_doc.at('.textEditor ul li:first-child').text.strip)[1]
    time = detail_doc.at('.textEditor ul li:nth-child(2)').text.strip.sub('服務時間:',
                                                                          '').strip || article.at_css('.date')&.text&.sub('期間: ', '')

    {
      img_url:,
      name:,
      organizer:,
      location:,
      time:,
      event_type:,
      working_type:,
      bonus:,
      viewer:,
      remark:,
      deadline:,
      link:,
      source_type:
    }
  end
end
