# frozen_string_literal: true

class IgivingParser
  SOURCE_TYPE = 'igiving'
  WEB_URL = 'https://www.igiving.org.tw/contents/volunteer'

  attr_reader :data, :total_pages

  def initialize
    @data = []
    doc = Nokogiri::HTML(Faraday.get(WEB_URL).body)
    @total_pages = doc.css('#volunteer ul.pagination li:last-child a')[0][:href][/\d+/].to_i
  end

  def parse
    (1..total_pages).each do |page|
      url = "#{WEB_URL}?page=#{page}#main"
      doc = Nokogiri::HTML(Faraday.get(url).body)
      rows = doc.css('div#volunteer div.row')
      rows.each do |row|
        img_url = "https://www.igiving.org.tw#{row.css('img')[0]['data-original']}"
        name = row.css('img')[0]['data-alt']
        link = "https://www.igiving.org.tw#{row.css('a')[0]['href']}"

        data << {
          img_url:,
          name:,
          link:
        }
      end
    end
    data
  end
end
