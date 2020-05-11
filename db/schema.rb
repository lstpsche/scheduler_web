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

ActiveRecord::Schema.define(version: 2020_03_02_192042) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

# Could not dump table "events" because of following StandardError
#   Unknown type 'event_weekday' for column 'weekday'

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
    t.boolean "private", default: true, null: false
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
    t.string "authentication_token", limit: 30
    t.string "bot_request_auth_token"
    t.boolean "global_bot_first_start", default: true, null: false
    t.boolean "students_bot_first_start", default: true, null: false
    t.boolean "admin", default: false, null: false
    t.string "tg_avatar_url", default: "", null: false
    t.index ["authentication_token"], name: "index_users_on_authentication_token", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
end
