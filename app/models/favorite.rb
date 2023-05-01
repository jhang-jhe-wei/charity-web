# frozen_string_literal: true

class Favorite < ApplicationRecord
  belongs_to :charitable_event
  belongs_to :user
  validates :charitable_event_id, uniqueness: { scope: :user_id }
end
