# frozen_string_literal: true

require_relative 'base_parser'

class Harvest365Parser < BaseParser
  SOURCE_TYPE = 'harvest365'
  WEB_URL = 'https://harvest365.org/wp_function/get_activity_bysearch.php'
  DETAIL_URL = 'https://harvest365.org/wp_function/get_activity_bynum.php'

  private

  def init_parser; end

  def parse_articles(page)
    response = Faraday.post(page, {
                              area: nil,
                              eventtype: nil,
                              startdate: nil
                            })
    JSON.parse(response.body)[1]
  end

  def parse_article(article)
    img_url = "https://harvest365.org#{article['va_coverimg']}"
    name = article['va_title']
    time = article['va_startdate']
    event_type = article['va_type']
    working_type = article['va_slots']
    viewer = nil # there is no 'viewer' key in the response
    deadline = article['va_reg_deadline']
    link = "https://harvest365.org/activitys/activity_content/?activity=#{article['va_seq']}"
    bonus = "服務時數#{article['va_service_hours']}小時"

    response = Faraday.post(DETAIL_URL, {
                              seq: article['va_seq']
                            })
    detail = JSON.parse(response.body)[1]
    location = detail['va_address'] || article['va_city']
    organizer = detail['org_name']
    remark = detail['va_contact_detail']

    {
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

  def pages
    [WEB_URL]
  end
end
