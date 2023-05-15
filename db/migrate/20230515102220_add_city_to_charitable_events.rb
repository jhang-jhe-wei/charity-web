class AddCityToCharitableEvents < ActiveRecord::Migration[7.0]
  def change
    add_column :charitable_events, :city, :integer
  end
end
