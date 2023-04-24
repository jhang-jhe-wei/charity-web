# frozen_string_literal: true

class EdenParser
  SOURCE_TYPE = 'eden'
  WEB_URL = 'https://volunteer.eden.org.tw/Hire'

  attr_reader :data

  def initialize
    @data = []
  end

  def parse

    conn = Faraday.new(WEB_URL, ssl: { verify: false })
    doc = Nokogiri::HTML(conn.get.body)
    items = doc.css('section div.item')

    items.each do |item|
      img_url = item.css('img.recruit-img').attr('src').text
      name = item.css('h4').text.strip
      organizer = nil # organizer data is not available in the HTML
      location = item.css('p:nth-child(2)').text.strip.split('：')[1]
      time = item.css('p:nth-child(3)').text.strip.split('：')[1]
      event_type = item.css('p:nth-child(4)').text.strip.split('：')[1]
      working_type = nil # working_type data is not available in the HTML
      bonues = item.css('label.label').map(&:text).join(' ')
      viewer = item.css('label').text.strip.split(' ')[0]
      remark = nil # remark data is not available in the HTML
      deadline = nil # deadline data is not available in the HTML
      link = 'https://volunteer.eden.org.tw' + item.css('a.goToRecruit').attr('href').text

      data << {
        img_url:,
        name:,
        organizer:,
        location:,
        time:,
        event_type:,
        working_type:,
        bonues:,
        viewer:,
        remark:,
        deadline:,
        link:,
        source_type: SOURCE_TYPE
      }
    end

    data
  end
end
