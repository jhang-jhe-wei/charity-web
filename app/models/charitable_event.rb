# frozen_string_literal: true

class CharitableEvent < ApplicationRecord
  store :extra_infos, accessors: %i[time viewer deadline]
  has_many :favorites, dependent: :destroy
  has_many :users, through: :favorites
end
