# frozen_string_literal: true

class CreateCharitableEvents < ActiveRecord::Migration[7.0]
  def change
    create_table :charitable_events do |t|
      t.text :extra_infos

      t.timestamps
    end
  end
end
