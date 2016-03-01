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

ActiveRecord::Schema.define(version: 20160229212201) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "key_focus_areas", force: :cascade do |t|
    t.string   "name",                                 null: false
    t.string   "goal",                    default: "", null: false
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
    t.integer  "created_by_user_id",                   null: false
    t.integer  "last_updated_by_user_id"
  end

  add_index "key_focus_areas", ["name"], name: "index_key_focus_areas_on_name", unique: true, using: :btree

  create_table "measure_reports", force: :cascade do |t|
    t.integer  "performance_measure_id",  null: false
    t.date     "date_start",              null: false
    t.date     "date_end",                null: false
    t.string   "performance",             null: false
    t.string   "status"
    t.string   "comments"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.integer  "created_by_user_id",      null: false
    t.integer  "last_updated_by_user_id"
  end

  add_index "measure_reports", ["performance_measure_id"], name: "index_measure_reports_on_performance_measure_id", using: :btree

  create_table "objectives", force: :cascade do |t|
    t.integer  "key_focus_area_id",                    null: false
    t.string   "name",                                 null: false
    t.string   "description",             default: "", null: false
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
    t.integer  "created_by_user_id",                   null: false
    t.integer  "last_updated_by_user_id"
  end

  add_index "objectives", ["key_focus_area_id"], name: "index_objectives_on_key_focus_area_id", using: :btree
  add_index "objectives", ["name", "key_focus_area_id"], name: "index_objectives_on_name_and_key_focus_area_id", unique: true, using: :btree

  create_table "performance_measures", force: :cascade do |t|
    t.integer  "measurable_id",                             null: false
    t.string   "measurable_type",                           null: false
    t.string   "description",                  default: "", null: false
    t.string   "target"
    t.string   "unit_of_measure",                           null: false
    t.string   "measurement_formula"
    t.string   "data_source"
    t.string   "rationale_for_target"
    t.string   "data_contact_person"
    t.string   "person_reporting_data_to_bms"
    t.string   "notes"
    t.datetime "created_at",                                null: false
    t.datetime "updated_at",                                null: false
    t.integer  "created_by_user_id",                        null: false
    t.integer  "last_updated_by_user_id"
  end

  add_index "performance_measures", ["measurable_type", "measurable_id"], name: "index_performance_measures_on_measurable_type_and_measurable_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.boolean  "admin",                  default: false
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  add_foreign_key "measure_reports", "performance_measures"
  add_foreign_key "objectives", "key_focus_areas"
end
