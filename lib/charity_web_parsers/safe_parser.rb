# frozen_string_literal: true

class SafeParser
  SOURCE_TYPE = 'www.safe.org.tw'
  WEB_URL = 'https://www.safe.org.tw/volunteer/'

  attr_reader :data

  def initialize
    @data = []
  end

  def parse
    doc = Nokogiri::HTML(Faraday.get(WEB_URL).body)
    volunteer_items = doc.css('.volunteerList .volunteerItem')

    volunteer_items.each do |item|
      img_url = item.at_css('.Img img')&.[]('src')
      name = item.at_css('.title a')&.text&.strip
      organizer = item.at_css('.classTitle')&.text
      event_type = item.at_css('.category')&.text
      working_type = item.at_css('.workingType')&.text
      bonus = item.at_css('.bonus')&.text
      viewer = item.at_css('.viewer')&.text
      remark = item.at_css('.remark')&.text
      deadline = item.at_css('.deadline')&.text
      link = item.at_css('.title a')&.[]('href')
      source_type = SOURCE_TYPE

      detail_doc = Nokogiri::HTML(Faraday.get('https://www.safe.org.tw/volunteer-detail/55__6/').body)
      location = /服務地點:\s*(.*)/.match(detail_doc.at('.textEditor ul li:first-child').text.strip)[1]
      time = detail_doc.at('.textEditor ul li:nth-child(2)').text.strip.sub('服務時間:',
                                                                            '').strip || item.at_css('.date')&.text&.sub('期間: ', '')

      data << ({
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
      })
    end
    Rails.logger.debug data
    data
  end
end
