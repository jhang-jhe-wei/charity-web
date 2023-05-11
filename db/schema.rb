# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2023_05_11_135336) do
  create_table "charitable_events", force: :cascade do |t|
    t.text "extra_infos"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "img_url"
    t.string "name"
    t.string "organizer"
    t.string "location"
    t.datetime "started_at"
    t.datetime "ended_at"
    t.string "event_type"
    t.string "working_type"
    t.string "bonus"
    t.date "registration_deadline"
    t.string "link"
    t.string "remark"
    t.string "source_type"
  end

  create_table "favorites", force: :cascade do |t|
    t.integer "charitable_event_id", null: false
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["charitable_event_id", "user_id"], name: "index_favorites_on_charitable_event_id_and_user_id", unique: true
    t.index ["charitable_event_id"], name: "index_favorites_on_charitable_event_id"
    t.index ["user_id"], name: "index_favorites_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "line_id"
    t.string "name"
    t.string "line_notify_token"
    t.string "image_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "role", default: "user"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "favorites", "charitable_events"
  add_foreign_key "favorites", "users"
end
