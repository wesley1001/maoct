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

ActiveRecord::Schema.define(version: 20160222003118) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "meetup_enrolls", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "meetup_id"
    t.integer  "meetup_fee_id"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.integer  "status",        default: 0
  end

  add_index "meetup_enrolls", ["meetup_fee_id"], name: "index_meetup_enrolls_on_meetup_fee_id", using: :btree
  add_index "meetup_enrolls", ["meetup_id"], name: "index_meetup_enrolls_on_meetup_id", using: :btree
  add_index "meetup_enrolls", ["user_id"], name: "index_meetup_enrolls_on_user_id", using: :btree

  create_table "meetup_fees", force: :cascade do |t|
    t.string   "key"
    t.integer  "value",      default: 0
    t.integer  "quota",      default: 0
    t.integer  "meetup_id"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.integer  "quota_used"
    t.decimal  "real_value"
  end

  add_index "meetup_fees", ["meetup_id"], name: "index_meetup_fees_on_meetup_id", using: :btree

  create_table "meetups", force: :cascade do |t|
    t.string   "title"
    t.datetime "open_at"
    t.datetime "close_at"
    t.datetime "deadline"
    t.string   "place"
    t.text     "intro"
    t.integer  "author_id"
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.integer  "meetup_enrolls_count", default: 0
  end

  add_index "meetups", ["author_id"], name: "index_meetups_on_author_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "provider"
    t.string   "uid"
    t.string   "nickname"
    t.integer  "sex"
    t.string   "avatar"
  end

  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  add_foreign_key "meetup_enrolls", "meetup_fees"
  add_foreign_key "meetup_enrolls", "meetups"
  add_foreign_key "meetup_enrolls", "users"
  add_foreign_key "meetup_fees", "meetups"
  add_foreign_key "meetups", "users", column: "author_id"
end
