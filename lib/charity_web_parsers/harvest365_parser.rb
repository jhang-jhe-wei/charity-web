# frozen_string_literal: true

class Harvest365Parser
  SOURCE_TYPE = 'harvest365'
  WEB_URL = 'https://harvest365.org/wp_function/get_activity_bysearch.php'
  attr_reader :data

  def initialize
    @data = []
  end

  def parse
    response = Faraday.post(WEB_URL, {
                              area: nil,
                              eventtype: nil,
                              startdate: nil,
                              enddate: nil,
                              keyword: nil
                            })
    posts = JSON.parse(response.body)[1]
    posts.each do |post|
      img_url = "https://harvest365.org#{post['va_coverimg']}"
      name = post['va_title']
      organizer = nil # there is no 'organizer' key in the response
      location = post['va_city']
      time = post['va_startdate']
      event_type = post['va_type']
      working_type = post['va_slots']
      bonus = nil # there is no 'bonus' key in the response
      viewer = nil # there is no 'viewer' key in the response
      remark = post['va_subtitle']
      deadline = post['va_reg_deadline']
      link = "https://harvest365.org/activitys/activity_register/?activity=#{post['va_seq']}"
      source_type = SOURCE_TYPE

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
