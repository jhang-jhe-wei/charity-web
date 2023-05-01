# frozen_string_literal: true

class AddColumnsToCharitableEvents < ActiveRecord::Migration[7.0]
  def change
    add_column :charitable_events, :img_url, :string
    add_column :charitable_events, :name, :string
    add_column :charitable_events, :organizer, :string
    add_column :charitable_events, :location, :string
    add_column :charitable_events, :started_at, :datetime
    add_column :charitable_events, :ended_at, :datetime
    add_column :charitable_events, :event_type, :string
    add_column :charitable_events, :working_type, :string
    add_column :charitable_events, :bonus, :string
    add_column :charitable_events, :registration_deadline, :date
    add_column :charitable_events, :link, :string
    add_column :charitable_events, :remark, :string
    add_column :charitable_events, :source_type, :string
  end
end
