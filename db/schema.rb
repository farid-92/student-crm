# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20160809161653) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "attendances", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "period_id"
    t.boolean  "attended"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "attendances", ["period_id"], name: "index_attendances_on_period_id", using: :btree
  add_index "attendances", ["user_id"], name: "index_attendances_on_user_id", using: :btree

  create_table "ckeditor_assets", force: :cascade do |t|
    t.string   "data_file_name",               null: false
    t.string   "data_content_type"
    t.integer  "data_file_size"
    t.integer  "assetable_id"
    t.string   "assetable_type",    limit: 30
    t.string   "type",              limit: 30
    t.integer  "width"
    t.integer  "height"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  add_index "ckeditor_assets", ["assetable_type", "assetable_id"], name: "idx_ckeditor_assetable", using: :btree
  add_index "ckeditor_assets", ["assetable_type", "type", "assetable_id"], name: "idx_ckeditor_assetable_type", using: :btree

  create_table "contact_lists", force: :cascade do |t|
    t.string   "title"
    t.boolean  "temp",       default: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  create_table "course_element_files", force: :cascade do |t|
    t.integer  "course_element_id"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.string   "file_file_name"
    t.string   "file_content_type"
    t.integer  "file_file_size"
    t.datetime "file_updated_at"
  end

  add_index "course_element_files", ["course_element_id"], name: "index_course_element_files_on_course_element_id", using: :btree

  create_table "course_element_materials", force: :cascade do |t|
    t.string   "title"
    t.text     "content"
    t.string   "element_type"
    t.integer  "course_element_id"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  add_index "course_element_materials", ["course_element_id"], name: "index_course_element_materials_on_course_element_id", using: :btree

  create_table "course_elements", force: :cascade do |t|
    t.integer  "course_id"
    t.string   "theme"
    t.string   "element_type"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "course_elements", ["course_id"], name: "index_course_elements_on_course_id", using: :btree

  create_table "courses", force: :cascade do |t|
    t.string   "name"
    t.string   "course_short_name"
    t.string   "practical_time"
    t.string   "theoretical_time"
    t.string   "cost"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  create_table "custom_lists", force: :cascade do |t|
    t.string   "phone"
    t.integer  "contact_list_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "custom_lists", ["contact_list_id"], name: "index_custom_lists_on_contact_list_id", using: :btree

  create_table "events", force: :cascade do |t|
    t.string   "title"
    t.datetime "start_date"
    t.datetime "end_date"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "extra_homeworks", force: :cascade do |t|
    t.integer  "group_id"
    t.integer  "user_id"
    t.integer  "period_id"
    t.integer  "course_id"
    t.integer  "homework_id"
    t.text     "feedback"
    t.boolean  "download_status",       default: false
    t.string   "teacher_id",            default: "f"
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
    t.string   "extra_hw_file_name"
    t.string   "extra_hw_content_type"
    t.integer  "extra_hw_file_size"
    t.datetime "extra_hw_updated_at"
  end

  add_index "extra_homeworks", ["course_id"], name: "index_extra_homeworks_on_course_id", using: :btree
  add_index "extra_homeworks", ["group_id"], name: "index_extra_homeworks_on_group_id", using: :btree
  add_index "extra_homeworks", ["period_id"], name: "index_extra_homeworks_on_period_id", using: :btree
  add_index "extra_homeworks", ["user_id"], name: "index_extra_homeworks_on_user_id", using: :btree

  create_table "group_memberships", force: :cascade do |t|
    t.integer  "group_id"
    t.integer  "user_id"
    t.boolean  "active"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "group_memberships", ["group_id"], name: "index_group_memberships_on_group_id", using: :btree
  add_index "group_memberships", ["user_id"], name: "index_group_memberships_on_user_id", using: :btree

  create_table "groups", force: :cascade do |t|
    t.integer  "course_id"
    t.string   "name"
    t.string   "group_short_name"
    t.date     "starts_at"
    t.date     "ends_at"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  add_index "groups", ["course_id"], name: "index_groups_on_course_id", using: :btree

  create_table "homeworks", force: :cascade do |t|
    t.integer  "course_id"
    t.integer  "group_id"
    t.integer  "user_id"
    t.integer  "period_id"
    t.string   "score"
    t.text     "feedback"
    t.datetime "deadline"
    t.string   "teacher_id",      default: "f"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.string   "hw_file_name"
    t.string   "hw_content_type"
    t.integer  "hw_file_size"
    t.datetime "hw_updated_at"
  end

  add_index "homeworks", ["course_id"], name: "index_homeworks_on_course_id", using: :btree
  add_index "homeworks", ["group_id"], name: "index_homeworks_on_group_id", using: :btree
  add_index "homeworks", ["period_id"], name: "index_homeworks_on_period_id", using: :btree
  add_index "homeworks", ["user_id"], name: "index_homeworks_on_user_id", using: :btree

  create_table "periods", force: :cascade do |t|
    t.integer  "course_element_id"
    t.string   "title"
    t.datetime "commence_datetime"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.string   "lesson_number"
    t.datetime "start_time"
    t.datetime "end_time"
    t.integer  "course_id"
    t.integer  "group_id"
    t.integer  "study_unit_id"
  end

  add_index "periods", ["course_element_id"], name: "index_periods_on_course_element_id", using: :btree
  add_index "periods", ["course_id"], name: "index_periods_on_course_id", using: :btree
  add_index "periods", ["group_id"], name: "index_periods_on_group_id", using: :btree
  add_index "periods", ["study_unit_id"], name: "index_periods_on_study_unit_id", using: :btree

  create_table "recipient_depositories", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "contact_list_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "recipient_depositories", ["contact_list_id"], name: "index_recipient_depositories_on_contact_list_id", using: :btree
  add_index "recipient_depositories", ["user_id"], name: "index_recipient_depositories_on_user_id", using: :btree

  create_table "senders", force: :cascade do |t|
    t.string   "name"
    t.integer  "sms_service_account_id"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "senders", ["sms_service_account_id"], name: "index_senders_on_sms_service_account_id", using: :btree

  create_table "sms_deliveries", force: :cascade do |t|
    t.string   "title"
    t.text     "content"
    t.integer  "sender_id"
    t.integer  "contact_list_id"
    t.boolean  "status",          default: false
    t.datetime "delivery_time"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.boolean  "smart_delivery",  default: false
  end

  add_index "sms_deliveries", ["contact_list_id"], name: "index_sms_deliveries_on_contact_list_id", using: :btree
  add_index "sms_deliveries", ["sender_id"], name: "index_sms_deliveries_on_sender_id", using: :btree

  create_table "sms_service_accounts", force: :cascade do |t|
    t.string   "login"
    t.string   "password"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "user_id"
  end

  add_index "sms_service_accounts", ["user_id"], name: "index_sms_service_accounts_on_user_id", using: :btree

  create_table "study_units", force: :cascade do |t|
    t.string   "unit"
    t.integer  "group_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "study_units", ["group_id"], name: "index_study_units_on_group_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                       default: "", null: false
    t.string   "encrypted_password",          default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",               default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
    t.string   "name"
    t.string   "surname"
    t.string   "gender"
    t.string   "first_phone"
    t.string   "second_phone"
    t.string   "skype"
    t.date     "birthdate"
    t.string   "passport_id"
    t.string   "passport_inn"
    t.date     "issue_date"
    t.string   "issued_by"
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
    t.string   "passport_photo_file_name"
    t.string   "passport_photo_content_type"
    t.integer  "passport_photo_file_size"
    t.datetime "passport_photo_updated_at"
    t.string   "password_txt"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  add_foreign_key "attendances", "periods"
  add_foreign_key "attendances", "users"
  add_foreign_key "course_element_files", "course_elements"
  add_foreign_key "course_element_materials", "course_elements"
  add_foreign_key "course_elements", "courses"
  add_foreign_key "custom_lists", "contact_lists"
  add_foreign_key "extra_homeworks", "courses"
  add_foreign_key "extra_homeworks", "groups"
  add_foreign_key "extra_homeworks", "homeworks"
  add_foreign_key "extra_homeworks", "periods"
  add_foreign_key "extra_homeworks", "users"
  add_foreign_key "group_memberships", "groups"
  add_foreign_key "group_memberships", "users"
  add_foreign_key "groups", "courses"
  add_foreign_key "homeworks", "courses"
  add_foreign_key "homeworks", "groups"
  add_foreign_key "homeworks", "periods"
  add_foreign_key "homeworks", "users"
  add_foreign_key "periods", "course_elements"
  add_foreign_key "periods", "courses"
  add_foreign_key "periods", "groups"
  add_foreign_key "periods", "study_units"
  add_foreign_key "recipient_depositories", "contact_lists"
  add_foreign_key "recipient_depositories", "users"
  add_foreign_key "senders", "sms_service_accounts"
  add_foreign_key "sms_deliveries", "contact_lists"
  add_foreign_key "sms_deliveries", "senders"
  add_foreign_key "sms_service_accounts", "users"
  add_foreign_key "study_units", "groups"
end
