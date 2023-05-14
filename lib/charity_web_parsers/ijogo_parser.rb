# frozen_string_literal: true

require_relative 'base_parser'

class IjogoParser < BaseParser
  SOURCE_TYPE = 'ijogo'
  WEB_URL = 'https://www.ijogo.com.tw/w/iJogo/Work'
  attr_reader :total_page

  private

  def init_parser
    doc = Nokogiri::HTML(Faraday.get(WEB_URL).body)
    @total_page = doc.css('.totalPage .num')[-1]&.text&.to_i || 1
  end

  def pages
    (1..total_page)
  end

  def parse_articles(page)
    current_url = "#{WEB_URL}?index=#{page}"
    doc = Nokogiri::HTML(Faraday.get(current_url).body)
    doc.css('.programs_cardInner')
  end

  def parse_article(article)
    img_url = article.css('.programs_image').attr('style').to_s.scan(/url\('([^']+)'\)/).flatten.first
    name = article.css('.programs_content h2').text.strip
    organizer = article.css('.programs_list li:nth-child(1) .main').text.strip
    location = article.css('.programs_list li:nth-child(3) .main').text.strip
    time = article.css('.programs_list li:nth-child(2) .main').text.strip
    event_type = article.css('.programs_list li:nth-child(4) .main').text.strip
    working_type = article.css('.programs_list li:nth-child(5) .main').text.strip
    bonus = [article.css('.programs_metaWrap .L .main').text.strip,
             article.css('.programs_metaWrap .R .main').text.strip].join(' | ')
    viewer = article.css('.programs_btm .view').text.strip.scan(/\d+/).first.to_i
    deadline = article.css('.programs_btm .timeout').text.strip == '已截止' ? '已截止' : ''
    link = "https://www.ijogo.com.tw#{article.css('.programs_content a').attr('href')}"

    {
      source_type: SOURCE_TYPE,
      img_url:,
      name:,
      organizer:,
      location:,
      time:,
      event_type:,
      working_type:,
      bonus:,
      viewer:,
      deadline:,
      link:
    }
  end
end
