# frozen_string_literal: true

class Favorite < ApplicationRecord
  belongs_to :charitable_event
  belongs_to :user
  validates :charitable_event, uniqueness: { scope: :user_id, message: :taken }
end
