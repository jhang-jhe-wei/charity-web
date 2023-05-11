# frozen_string_literal: true

class CharitableEvent < ApplicationRecord
  store :extra_infos, accessors: %i[time viewer deadline]
  has_many :favorites, dependent: :destroy
  has_many :users, through: :favorites
  before_save :parse_time, if: -> { time_changed? }
  before_save :parse_deadline, if: -> { deadline_changed? }

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

  private

  def parse_time
    if time == 'N/A' || time.strip.empty?
      self.started_at = nil
      self.ended_at = nil
      return
    end

    if time.include?('~')
      parts = time.split('~').map(&:strip)
      self.started_at = parse_datetime(parts[0])
      self.ended_at = parse_datetime(parts[1])
    elsif time.include?('至')
      parts = time.split('至').map(&:strip)
      self.started_at = parse_datetime(parts[0])
      self.ended_at = parse_datetime(parts[1])
    else
      self.started_at = parse_datetime(time)
      self.ended_at = nil
    end
  rescue StandardError => e
    Rails.logger.error(e.message)
    self.started_at = nil
    self.ended_at = nil
  end

  def parse_datetime(datetime_str)
    date_str, time_str = datetime_str.split(' ')
    year, month, day = date_str.split('/').map(&:to_i)
    hour, minute, second = time_str.split(':').map(&:to_i)
    DateTime.new(year, month, day, hour, minute, second)
  end

  def parse_deadline
    self.registration_deadline = if deadline == 'N/A'
                                   nil
                                 elsif deadline == '已截止'
                                   DateTime.now # Set to current time (past)
                                 else
                                   DateTime.parse(deadline)
                                 end
  rescue StardardError => e
    Rails.logger.error(e.message)
    self.registration_deadline = nil
  end
end
