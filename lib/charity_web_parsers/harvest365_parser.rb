# frozen_string_literal: true

class Harvest365Parser
  SOURCE_TYPE = 'harvest365'
  WEB_URL = 'https://harvest365.org/wp_function/get_activity_bysearch.php'
  DETAIL_URL = 'https://harvest365.org/wp_function/get_activity_bynum.php'
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
      time = post['va_startdate']
      event_type = post['va_type']
      working_type = post['va_slots']
      viewer = nil # there is no 'viewer' key in the response
      deadline = post['va_reg_deadline']
      link = "https://harvest365.org/activitys/activity_content/?activity=#{post['va_seq']}"
      bonus = "服務時數#{post['va_service_hours']}小時"

      response = Faraday.post(DETAIL_URL, {
                                seq: post['va_seq']
                              })
      detail = JSON.parse(response.body)[1]
      location = detail['va_address'] || post['va_city']
      organizer = detail['org_name']
      remark = detail['va_contact_detail']

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
