# frozen_string_literal: true

require_relative 'base_parser'

class CathaylifeParser < BaseParser
  private

  def pages
    [0]
  end

  def parse_article(_article)
    {
      img_url: 'https://agent2.cathaylife.com.tw/PDZZ/Path/META_IMG/OD/AY/20210727113439.jpg',
      name: '國泰卓越獎助計畫',
      organizer: '國泰慈善基金會',
      location: '全國',
      event_type: '獎助',
      bonus: '20萬元',
      link: 'https://patron.cathaylife.com.tw/ODAY/F1/ODAYF100',
      source_type: '國泰慈善基金會'
    }
  end

  def parse_articles(_page)
    [0]
  end
end
