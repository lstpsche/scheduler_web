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

ActiveRecord::Schema.define(version: 2019_11_18_200714) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "events", force: :cascade do |t|
    t.string "weekday", null: false
    t.string "time", null: false
    t.string "info", null: false
    t.bigint "schedule_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "additional_info"
    t.index ["schedule_id"], name: "index_events_on_schedule_id"
  end

  create_table "schedule_users", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "schedule_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "author", default: false, null: false
    t.index ["schedule_id"], name: "index_schedule_users_on_schedule_id"
    t.index ["user_id"], name: "index_schedule_users_on_user_id"
  end

  create_table "schedules", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "additional_info"
    t.integer "customed_by"
    t.boolean "customed", default: false, null: false
    t.string "university"
    t.string "faculty"
    t.string "course"
    t.string "department"
    t.string "group"
    t.boolean "for_student", default: false, null: false
  end

  create_table "student_settings", force: :cascade do |t|
    t.bigint "user_id"
    t.string "university", null: false
    t.string "faculty", null: false
    t.string "course", null: false
    t.string "department"
    t.string "group"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_student_settings_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name", default: "", null: false
    t.string "last_name", default: "", null: false
    t.string "username", null: false
    t.string "language_code", default: "en", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.jsonb "context", default: "{}"
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.boolean "one_time_password", default: false, null: false
    t.string "authentication_token", limit: 30
    t.string "encrypted_otp", default: "", null: false
    t.string "logged_in_via"
    t.datetime "otp_generated_at", default: "2019-10-11 21:52:00", null: false
    t.string "bot_request_auth_token"
    t.index ["authentication_token"], name: "index_users_on_authentication_token", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
