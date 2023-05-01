# frozen_string_literal: true

class CharitableEvent < ApplicationRecord
  store :extra_infos, accessors: %i[time viewer deadline]
  has_many :favorites, dependent: :destroy
  has_many :users, through: :favorites

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
