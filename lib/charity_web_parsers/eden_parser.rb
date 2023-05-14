# frozen_string_literal: true

require_relative 'base_parser'

class EdenParser < BaseParser
  SOURCE_TYPE = 'eden'
  WEB_URL = 'https://volunteer.eden.org.tw/Hire'
  attr_reader :conn

  private

  def pages
    [WEB_URL]
  end

  def parse_articles(page)
    @conn = Faraday.new(page, ssl: { verify: false })
    doc = Nokogiri::HTML(conn.get.body)
    doc.css('section div.item')
  end

  def parse_article(article)
    img_url = article.css('img.recruit-img').attr('src').text
    name = article.css('h4').text.strip
    location = article.css('p:nth-child(3)').text.strip.split('：')[1]
    time = article.css('p:nth-child(4)').text.strip.split('：')[1]
    event_type = article.css('label.label').map(&:text).join(' ')
    link = "https://volunteer.eden.org.tw#{article.css('a.goToRecruit').attr('href').text}"
    detail_doc = Nokogiri::HTML(conn.get(link).body)
    organizer = detail_doc.at('body > div > div > section.service-say > div > div > div:nth-child(1) > div.col-12.col-sm-10.content > a').text
    working_type = detail_doc.at('div.hire-info p:contains("服務類別")').text.gsub('服務類別：', '').strip
    bonus = nil
    viewer = nil
    remark = nil
    deadline = nil

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
      source_type: SOURCE_TYPE
    }
  end
end
