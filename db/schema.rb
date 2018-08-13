# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2018_08_13_180716) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "bookings", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "vessel_id"
    t.date "start_date"
    t.date "end_date"
    t.integer "total_price"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_bookings_on_user_id"
    t.index ["vessel_id"], name: "index_bookings_on_vessel_id"
  end

  create_table "options", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.integer "price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "reviews", force: :cascade do |t|
    t.string "content"
    t.integer "rating"
    t.bigint "vessel_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["vessel_id"], name: "index_reviews_on_vessel_id"
  end

  create_table "selected_options", force: :cascade do |t|
    t.integer "quantity"
    t.bigint "booking_id"
    t.bigint "option_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["booking_id"], name: "index_selected_options_on_booking_id"
    t.index ["option_id"], name: "index_selected_options_on_option_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "vessel_options", force: :cascade do |t|
    t.bigint "vessel_id"
    t.bigint "option_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["option_id"], name: "index_vessel_options_on_option_id"
    t.index ["vessel_id"], name: "index_vessel_options_on_vessel_id"
  end

  create_table "vessels", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.integer "price"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_vessels_on_user_id"
  end

  add_foreign_key "bookings", "users"
  add_foreign_key "bookings", "vessels"
  add_foreign_key "reviews", "vessels"
  add_foreign_key "selected_options", "bookings"
  add_foreign_key "selected_options", "options"
end
