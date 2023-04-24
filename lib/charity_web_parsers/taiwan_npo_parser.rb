# frozen_string_literal: true

class TaiwanNpoParser
  SOURCE_TYPE = 'taiwan_npo'
  WEB_URL = 'https://www.npo.org.tw/volunteerlist.aspx?tid=143'

  attr_reader :data

  def initialize
    @data = []
  end

  def parse
    doc = Nokogiri::HTML(Faraday.get(WEB_URL).body)
    total_pages = doc.css('#page select option:last-child').text.to_i
    1.upto(total_pages) do |page|
      debugger
      doc = Nokogiri::HTML(Faraday.get(WEB_URL + "&nowPage=#{page}").body)
        doc.css('.list tbody tr').each do |row|
          img_url = "https://www.npo.org.tw/upload/%7B637520089479841839%7D_common_header_logo.png"
          name = row.css("[data-th='志工名稱']").text.strip
          organizer = row.css("[data-th='機構名稱']").text.strip
          location = row.css("[data-th='工作地點']").text.strip
          time = row.css("[data-th='刊登日期']").text.strip
          event_type = row.css("[data-th='志工類別']").text.strip
          working_type = nil
          bonus = nil
          viewer = nil
          remark = nil
          deadline = nil
          link = "https://www.npo.org.tw/#{row['onclick'][/location.href='(.*?)'/, 1]}"

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
    end
    data
  end
end
