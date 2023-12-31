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

ActiveRecord::Schema[7.0].define(version: 2023_11_08_224503) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "uuid-ossp"

  # Custom types defined in this database.
  # Note that some types may not work with other database engines. Be careful if changing database.
  create_enum "appointment_status", ["booked", "closed", "cancelled"]

  create_table "appointments", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.uuid "service_id"
    t.uuid "user_id"
    t.string "fname"
    t.string "lname"
    t.string "email"
    t.datetime "startdatetime", precision: nil
    t.datetime "enddatetime", precision: nil
    t.decimal "amount_paid"
    t.string "status", default: "booked", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "hours", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.uuid "user_id"
    t.integer "day"
    t.time "start_time"
    t.time "end_time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "reset_password_sessions", force: :cascade do |t|
    t.uuid "user_id"
    t.string "session_token"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "services", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.uuid "user_id", null: false
    t.string "name"
    t.text "description"
    t.decimal "price"
    t.integer "duration"
    t.boolean "is_published", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "hidden", default: false
    t.text "short_description"
  end

  create_table "users", primary_key: "user_id", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.string "fname", null: false
    t.string "email"
    t.string "password_digest"
    t.string "about"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "lname", default: "", null: false
    t.string "profile_image"
    t.string "username"
  end

  add_foreign_key "appointments", "services"
  add_foreign_key "appointments", "users", primary_key: "user_id"
  add_foreign_key "hours", "users", primary_key: "user_id"
  add_foreign_key "services", "users", primary_key: "user_id"
end
