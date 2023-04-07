# frozen_string_literal: true

class RemoveUniqueEmailFromUsers < ActiveRecord::Migration[7.0]
  def up
    change_column :users, :email, :string, null: true, default: nil
  end

  def down
    change_column_null :users, :email, false, SecureRandom.uuid
  end
end
