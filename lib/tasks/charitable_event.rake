# frozen_string_literal: true

require_relative '../charity_web_parsers/ijogo_parser'
require_relative '../charity_web_parsers/taipei_volunteer_parser'
require_relative '../charity_web_parsers/taiwan_npo_parser'
require_relative '../charity_web_parsers/harvest365_parser'
require_relative '../charity_web_parsers/igiving_parser'
require_relative '../charity_web_parsers/safe_parser'
require_relative '../charity_web_parsers/eden_parser'

PARSERS = [
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
      CharitableEvent.destroy_all
      PARSERS.each do |parser|
        parser.new.parse.each { |event| CharitableEvent.create!(event) }
      end
    end
  end
end
