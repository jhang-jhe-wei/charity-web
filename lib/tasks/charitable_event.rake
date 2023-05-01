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
      CharitableEvent.create!({
                                img_url: 'https://agent2.cathaylife.com.tw/PDZZ/Path/META_IMG/OD/AY/20210727113439.jpg',
                                name: '國泰卓越獎助計畫',
                                organizer: '國泰慈善基金會',
                                location: '全國',
                                time: '2022/08/01 ~ 2022/10/07',
                                event_type: '獎助',
                                bonus: '20萬元',
                                deadline: '2021/10/07',
                                link: 'https://patron.cathaylife.com.tw/ODAY/F1/ODAYF100',
                                source_type: '國泰慈善基金會'
                              })
      PARSERS.each do |parser|
        parser.new.parse.each { |event| CharitableEvent.create!(event) }
      end
    end
  end
end
