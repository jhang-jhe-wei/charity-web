# frozen_string_literal: true

class CharitableEvent < ApplicationRecord
  store :extra_infos,
        accessors: %i[img_url name organizer location time event_type working_type bonus viewer remark deadline link
                      source_type]

  def name
    super.presence || 'N/A'
  end

  def organizer
    super.presence || 'N/A'
  end

  def location
    super.presence || 'N/A'
  end

  def time
    super.presence || 'N/A'
  end

  def event_type
    super.presence || 'N/A'
  end

  def working_type
    super.presence || 'N/A'
  end

  def bonus
    super.presence || 'N/A'
  end

  def viewer
    super.presence || 'N/A'
  end

  def remark
    super.presence || 'N/A'
  end

  def deadline
    super.presence || 'N/A'
  end
end
