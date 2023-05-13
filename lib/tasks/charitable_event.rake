# frozen_string_literal: true

require_relative '../charity_web_parsers/ijogo_parser'
require_relative '../charity_web_parsers/taipei_volunteer_parser'
require_relative '../charity_web_parsers/taiwan_npo_parser'
require_relative '../charity_web_parsers/harvest365_parser'
require_relative '../charity_web_parsers/igiving_parser'
require_relative '../charity_web_parsers/safe_parser'
require_relative '../charity_web_parsers/eden_parser'
require_relative '../charity_web_parsers/cathaylife_parser'

PARSERS = [
  CathaylifeParser,
  Harvest365Parser,
  TaiwanNpoParser,
  TaipeiVolunteerParser,
  IjogoParser,
  IgivingParser,
  SafeParser,
  EdenParser
].freeze

namespace :charitable_event do
  desc 'load from online'
  task load_data_from_online: :environment do
    ActiveRecord::Base.transaction do
      PARSERS.each do |parser|
        parser.new.parse.each do |data|
          Rails.logger.info("original data: #{data}")
          attributes = convert_data_to_attributes(data)
          Rails.logger.info("modified data: #{attributes}")
          CharitableEvent
            .create_with(attributes)
            .find_or_create_by(link: attributes[:link])
        end
      end
    end
  end
end

def convert_data_to_attributes(data)
  attributes = default_event_values.merge(data) do |_key, old_val, new_val|
    (new_val.presence || old_val)
  end
  started_at, ended_at = parse_time(attributes[:time])
  registration_deadline = parse_deadline(attributes[:deadline])
  attributes.merge({
                     started_at:,
                     ended_at:,
                     registration_deadline:
                   })
end

# rubocop:disable Metrics/MethodLength
def default_event_values
  {
    img_url: 'https://obs.line-scdn.net/0h_Tml_pONAHtQFRIt2gR_LABICxljdx5wciEUHD5qAkMgThslLA86eipHBSw4XhhRZCMQbXRuASt1dw9GbBIqaXF9XQI7d0VWJyMEYjZpKzshdSIsKg/f256x256',
    name: '請至官網查看',
    organizer: '請至官網查看',
    location: '請至官網查看',
    event_type: '請至官網查看',
    working_type: '請至官網查看',
    bonus: '請至官網查看',
    link: '請至官網查看',
    remark: '請至官網查看',
    source_type: '請至官網查看',
    time: '請至官網查看',
    viewer: '請至官網查看',
    deadline: '請至官網查看'
  }
end
# rubocop:enable Metrics/MethodLength

def parse_time(time)
  # Initialize variables
  started_at = nil
  ended_at = nil

  # Return nil if time is nil or empty
  return [started_at, ended_at] if time.blank?

  # Normalize the time format
  time = time.gsub('週', '周').gsub(/[\n\t\s]/, '')

  # Check for specific patterns
  if time.include?('~')
    parts = time.split('~').map(&:strip)
    started_at = parse_datetime(parts[0])
    ended_at = parse_datetime(parts[1])
  elsif time.include?('至') || time.include?('-')
    parts = time.split(/至|-/).map(&:strip)
    started_at = parse_datetime(parts[0])
    ended_at = parse_datetime(parts[1])
  elsif time.match?(%r{\d{4}/\d{2}/\d{2}})
    started_at = parse_datetime(time)
  end

  [started_at, ended_at]
end

def parse_datetime(datetime_str)
  # Implement your datetime parsing logic here
  # Return the parsed datetime or nil if parsing fails
  # Example:

  DateTime.parse(datetime_str)
rescue StandardError
  nil
end

def parse_deadline(deadline)
  if deadline == 'N/A'
    nil
  elsif deadline == '已截止'
    DateTime.now # Set to current time (past)
  else
    DateTime.parse(deadline)
  end
rescue StandardError => e
  Rails.logger.error(e.message)
  nil
end
