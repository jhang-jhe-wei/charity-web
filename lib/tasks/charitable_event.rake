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
    parsed_count = 0
    saved_count = 0

    ActiveRecord::Base.transaction do
      PARSERS.each do |parser|
        parser.new.parse.each do |attr|
          parsed_count += 1

          event = CharitableEvent.create_with(attr).find_or_create_by(link: attr[:link])
          saved_count += 1 if event.persisted?
        end
      end
    end

    Rails.logger.info("共爬取 #{parsed_count} 筆資料, 新增 #{saved_count} 筆資料.")
  end
end
