# frozen_string_literal: true

class IjogoParser
  SOURCE_TYPE = 'ijogo'
  WEB_URL = 'https://www.ijogo.com.tw/w/iJogo/Work'

  attr_reader :total_page, :data

  def initialize
    doc = Nokogiri::HTML(Faraday.get(WEB_URL).body)
    @total_page = doc.css('.totalPage .num')[-1]&.text&.to_i || 1
    @data = []
  end

  def parse
    (1..total_page).each do |page|
      data.push(*parse_page(page))
    end
    data
  end

  private

  def parse_page(page)
    current_url = "#{WEB_URL}?index=#{page}"
    doc = Nokogiri::HTML(Faraday.get(current_url).body)
    program_cards = doc.css('.programs_cardInner')
    program_cards.map do |card|
      img_url = card.css('.programs_image').attr('style').to_s.scan(/url\('([^']+)'\)/).flatten.first
      name = card.css('.programs_content h2').text.strip
      organizer = card.css('.programs_list li:nth-child(1) .main').text.strip
      location = card.css('.programs_list li:nth-child(3) .main').text.strip
      time = card.css('.programs_list li:nth-child(2) .main').text.strip
      event_type = card.css('.programs_list li:nth-child(4) .main').text.strip
      working_type = card.css('.programs_list li:nth-child(5) .main').text.strip
      bonus = [card.css('.programs_metaWrap .L .main').text.strip,
               card.css('.programs_metaWrap .R .main').text.strip].join(' | ')
      viewer = card.css('.programs_btm .view').text.strip.scan(/\d+/).first.to_i
      deadline = card.css('.programs_btm .timeout').text.strip == '已截止' ? '已截止' : ''
      link = "https://www.ijogo.com.tw#{card.css('.programs_content a').attr('href')}"

      data_hash = {
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

      Rails.logger.debug "Data Hash: #{data_hash.inspect}"
      data_hash
    end
  end
end
