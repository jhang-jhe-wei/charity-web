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
      location = item.at_css('.location')&.text
      time = item.at_css('.date')&.text
      event_type = item.at_css('.category')&.text
      working_type = item.at_css('.workingType')&.text
      bonus = item.at_css('.bonus')&.text
      viewer = item.at_css('.viewer')&.text
      remark = item.at_css('.remark')&.text
      deadline = item.at_css('.deadline')&.text
      link = item.at_css('.title a')&.[]('href')
      source_type = SOURCE_TYPE

      data << {
        img_url: img_url,
        name: name,
        organizer: organizer,
        location: location,
        time: time,
        event_type: event_type,
        working_type: working_type,
        bonus: bonus,
        viewer: viewer,
        remark: remark,
        deadline: deadline,
        link: link,
        source_type: source_type
      }
    end
    data
  end
end
