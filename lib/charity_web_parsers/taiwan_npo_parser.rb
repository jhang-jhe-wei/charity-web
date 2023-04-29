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
    data = []
    1.upto(total_pages) do |page|
      doc = Nokogiri::HTML(Faraday.get(WEB_URL + "&nowPage=#{page}").body)
      doc.css('.list tbody tr').each do |row|
        img_url = 'https://www.npo.org.tw/upload/%7B637520089479841839%7D_common_header_logo.png'
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

        article_doc = Nokogiri::HTML(Faraday.get(link).body)
        organizer = article_doc.at('div.intro_list h4:contains("機構名稱")')&.text&.sub('機構名稱：', '')&.strip
        location = article_doc.at('div.intro_list h4:contains("工作地點")')&.text&.sub('工作地點：', '')&.strip
        time = article_doc.at('div.intro_list span.date')&.text
        working_type = [article_doc.at('div.intro_list h4:contains("服務性質：")')&.text&.sub('服務性質：', '')&.strip,
                        article_doc.at('div.intro_list h4:contains("工作時間")')&.text&.sub('工作時間：', '')&.strip].join('|')
        event_type = article_doc.at('div.intro_list h4:contains("志工類別")')&.text&.sub('志工類別：', '')&.strip
        bonus = article_doc.at('div.intro_list h4:contains("志工福利：")')&.text&.sub('志工福利：', '')&.strip

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
