# frozen_string_literal: true

require_relative '../charity_web_parsers/ijogo_parser'

namespace :charitable_event do
  desc 'load from online'
  task load_data_from_online: :environment do
    CharitableEvent.destroy_all
    charitable_events = IjogoParser.new.parse
    charitable_events.each do |event|
      CharitableEvent.create!(event)
    end
  end
end
