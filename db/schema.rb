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

ActiveRecord::Schema.define(version: 20160511102542) do

  create_table "attendances", force: :cascade do |t|
    t.integer  "student_id"
    t.integer  "period_id"
    t.boolean  "attended"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "attendances", ["period_id"], name: "index_attendances_on_period_id"
  add_index "attendances", ["student_id"], name: "index_attendances_on_student_id"

  create_table "contact_lists", force: :cascade do |t|
    t.string   "title"
    t.boolean  "temp",       default: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  create_table "course_elements", force: :cascade do |t|
    t.integer  "course_id"
    t.string   "theme"
    t.string   "element_type"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "course_elements", ["course_id"], name: "index_course_elements_on_course_id"

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

  add_index "custom_lists", ["contact_list_id"], name: "index_custom_lists_on_contact_list_id"

  create_table "group_memberships", force: :cascade do |t|
    t.integer  "group_id"
    t.integer  "student_id"
    t.boolean  "active"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "group_memberships", ["group_id"], name: "index_group_memberships_on_group_id"
  add_index "group_memberships", ["student_id"], name: "index_group_memberships_on_student_id"

  create_table "groups", force: :cascade do |t|
    t.integer  "course_id"
    t.string   "name"
    t.string   "group_short_name"
    t.date     "starts_at"
    t.date     "ends_at"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  add_index "groups", ["course_id"], name: "index_groups_on_course_id"

  create_table "periods", force: :cascade do |t|
    t.integer  "course_element_id"
    t.string   "title"
    t.datetime "commence_datetime"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  add_index "periods", ["course_element_id"], name: "index_periods_on_course_element_id"

  create_table "recipient_depositories", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "contact_list_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "recipient_depositories", ["contact_list_id"], name: "index_recipient_depositories_on_contact_list_id"
  add_index "recipient_depositories", ["user_id"], name: "index_recipient_depositories_on_user_id"

  create_table "senders", force: :cascade do |t|
    t.string   "name"
    t.integer  "sms_service_account_id"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "senders", ["sms_service_account_id"], name: "index_senders_on_sms_service_account_id"

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

  add_index "sms_deliveries", ["contact_list_id"], name: "index_sms_deliveries_on_contact_list_id"
  add_index "sms_deliveries", ["sender_id"], name: "index_sms_deliveries_on_sender_id"

  create_table "sms_service_accounts", force: :cascade do |t|
    t.string   "login"
    t.string   "password"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "user_id"
  end

  add_index "sms_service_accounts", ["user_id"], name: "index_sms_service_accounts_on_user_id"

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
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
