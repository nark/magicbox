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

ActiveRecord::Schema.define(version: 2019_01_16_213226) do

  create_table "conditions", force: :cascade do |t|
    t.string "name"
    t.integer "data_type_id"
    t.integer "predicate"
    t.integer "target_value"
    t.time "start_time"
    t.time "end_time"
    t.integer "scenario_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "crons", force: :cascade do |t|
    t.integer "scenario_id"
    t.integer "device_id"
    t.string "command"
    t.integer "period"
    t.time "start_time"
    t.integer "delay"
    t.integer "repeats"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.time "end_time"
    t.integer "cron_type", default: 0
    t.datetime "last_exec_time"
    t.integer "time_value"
    t.integer "duration"
  end

  create_table "data_types", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "devices", force: :cascade do |t|
    t.integer "device_type"
    t.integer "device_state"
    t.string "name"
    t.string "product_reference"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "pin_number", default: 0
    t.integer "pin_type", default: 0
    t.datetime "last_start_date"
    t.integer "default_duration", default: 1000
  end

  create_table "devices_data_types", force: :cascade do |t|
    t.integer "device_id"
    t.integer "data_type_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "events", force: :cascade do |t|
    t.integer "event_type"
    t.text "message"
    t.json "data"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "operations", force: :cascade do |t|
    t.string "command"
    t.integer "delay"
    t.integer "retries"
    t.integer "device_id"
    t.string "description"
    t.integer "condition_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "samples", force: :cascade do |t|
    t.string "product_reference"
    t.integer "data_type_id"
    t.text "value"
    t.string "unit"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "scenarios", force: :cascade do |t|
    t.string "name"
    t.integer "subject_id"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "enabled", default: false
  end

  create_table "sensor_datatypes", force: :cascade do |t|
    t.integer "data_type_id"
    t.integer "sensor_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "sensors", force: :cascade do |t|
    t.string "name"
    t.string "product_reference"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "subjects", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "authentication_token", limit: 30
    t.index ["authentication_token"], name: "index_users_on_authentication_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
