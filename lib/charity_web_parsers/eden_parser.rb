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
      location = item.css('p:nth-child(3)').text.strip.split('：')[1]
      time = item.css('p:nth-child(4)').text.strip.split('：')[1]
      event_type = item.css('label.label').map(&:text).join(' ')
      link = "https://volunteer.eden.org.tw#{item.css('a.goToRecruit').attr('href').text}"

      detail_doc = Nokogiri::HTML(conn.get(link).body)
      organizer = detail_doc.at('body > div > div > section.service-say > div > div > div:nth-child(1) > div.col-12.col-sm-10.content > a').text
      working_type = detail_doc.at('div.hire-info p:contains("服務類別")').text.gsub('服務類別：', '').strip
      bonus = nil
      viewer = nil
      remark = nil
      deadline = nil

      data << {
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
    data
  end
end
