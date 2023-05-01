# frozen_string_literal: true

class AddIndexToFavorites < ActiveRecord::Migration[7.0]
  def change
    add_index :favorites, %i[charitable_event_id user_id], unique: true
  end
end
