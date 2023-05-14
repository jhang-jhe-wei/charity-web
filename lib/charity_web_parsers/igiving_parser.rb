# frozen_string_literal: true

require_relative 'base_parser'

class IgivingParser < BaseParser
  SOURCE_TYPE = 'igiving'
  WEB_URL = 'https://www.igiving.org.tw/contents/volunteer'

  attr_reader :total_pages

  private

  def pages
    doc = Nokogiri::HTML(Faraday.get(WEB_URL).body)
    total_pages = doc.css('#volunteer ul.pagination li:last-child a')[0][:href][/\d+/].to_i
    (1..total_pages)
  end

  def parse_articles(page)
    url = "#{WEB_URL}?page=#{page}#main"
    doc = Nokogiri::HTML(Faraday.get(url).body)
    doc.css('div#volunteer div.row')
  end

  def parse_article(article)
    img_url = "https://www.igiving.org.tw#{article.css('img')[0]['data-original']}"
    name = article.css('img')[0]['data-alt']
    link = "https://www.igiving.org.tw#{article.css('a')[0]['href']}"
    {
      img_url:,
      name:,
      link:
    }
  end
end
