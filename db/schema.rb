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

ActiveRecord::Schema.define(version: 20160607154047) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "initiative_goal_outcomes", force: :cascade do |t|
    t.integer  "initiative_planning_guide_id", null: false
    t.string   "goal",                         null: false
    t.text     "outcome"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  add_index "initiative_goal_outcomes", ["initiative_planning_guide_id"], name: "index_initiative_goal_outcomes_on_initiative_planning_guide_id", using: :btree

  create_table "initiative_humans", force: :cascade do |t|
    t.integer  "initiative_planning_guide_id"
    t.string   "name",                         null: false
    t.string   "department"
    t.string   "email"
    t.string   "category",                     null: false
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  add_index "initiative_humans", ["initiative_planning_guide_id"], name: "index_initiative_humans_on_initiative_planning_guide_id", using: :btree

  create_table "initiative_linked_measures", force: :cascade do |t|
    t.integer  "initiative_planning_guide_id"
    t.integer  "performance_measure_id"
    t.text     "comments"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  add_index "initiative_linked_measures", ["initiative_planning_guide_id"], name: "index_linked_measures_on_guide_id", using: :btree
  add_index "initiative_linked_measures", ["performance_measure_id"], name: "index_initiative_linked_measures_on_performance_measure_id", using: :btree

  create_table "initiative_plan_years", force: :cascade do |t|
    t.integer  "initiative_planning_guide_id"
    t.integer  "year",                         null: false
    t.boolean  "expired"
    t.date     "date_expired"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  add_index "initiative_plan_years", ["initiative_planning_guide_id"], name: "index_initiative_plan_years_on_initiative_planning_guide_id", using: :btree

  create_table "initiative_planning_guides", force: :cascade do |t|
    t.integer  "objective_id"
    t.string   "description",             null: false
    t.string   "initiative_stage"
    t.string   "project_commitment"
    t.text     "initiative_overview"
    t.text     "major_milestones"
    t.integer  "created_by_user_id"
    t.integer  "last_updated_by_user_id"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  add_index "initiative_planning_guides", ["objective_id"], name: "index_initiative_planning_guides_on_objective_id", using: :btree

  create_table "key_focus_areas", force: :cascade do |t|
    t.string   "name",                                 null: false
    t.string   "goal",                    default: "", null: false
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
    t.integer  "created_by_user_id"
    t.integer  "last_updated_by_user_id"
    t.string   "logo_file_name"
    t.string   "logo_content_type"
    t.integer  "logo_file_size"
    t.datetime "logo_updated_at"
  end

  add_index "key_focus_areas", ["name"], name: "index_key_focus_areas_on_name", unique: true, using: :btree

  create_table "measure_reports", force: :cascade do |t|
    t.integer  "performance_measure_id",                  null: false
    t.date     "date_start",                              null: false
    t.date     "date_end",                                null: false
    t.string   "performance"
    t.string   "status"
    t.string   "comments"
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
    t.integer  "created_by_user_id"
    t.integer  "last_updated_by_user_id"
    t.string   "bms_comments"
    t.boolean  "expired",                 default: false, null: false
  end

  add_index "measure_reports", ["performance_measure_id"], name: "index_measure_reports_on_performance_measure_id", using: :btree

  create_table "objectives", force: :cascade do |t|
    t.integer  "key_focus_area_id",                    null: false
    t.string   "name",                                 null: false
    t.string   "description",             default: "", null: false
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
    t.integer  "created_by_user_id"
    t.integer  "last_updated_by_user_id"
  end

  add_index "objectives", ["key_focus_area_id"], name: "index_objectives_on_key_focus_area_id", using: :btree
  add_index "objectives", ["name", "key_focus_area_id"], name: "index_objectives_on_name_and_key_focus_area_id", unique: true, using: :btree

  create_table "performance_factor_entries", force: :cascade do |t|
    t.integer  "performance_factor_id", null: false
    t.integer  "measure_report_id",     null: false
    t.string   "data",                  null: false
    t.text     "comments"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  add_index "performance_factor_entries", ["measure_report_id"], name: "index_performance_factor_entries_on_measure_report_id", using: :btree
  add_index "performance_factor_entries", ["performance_factor_id"], name: "index_performance_factor_entries_on_performance_factor_id", using: :btree

  create_table "performance_factors", force: :cascade do |t|
    t.integer  "performance_measure_id", null: false
    t.string   "label_text",             null: false
    t.string   "field_type",             null: false
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "performance_factors", ["performance_measure_id"], name: "index_performance_factors_on_performance_measure_id", using: :btree

  create_table "performance_measures", force: :cascade do |t|
    t.integer  "measurable_id",                                   null: false
    t.string   "measurable_type",                                 null: false
    t.string   "description",                        default: "", null: false
    t.string   "target"
    t.string   "unit_of_measure",                                 null: false
    t.string   "measurement_formula"
    t.string   "data_source"
    t.string   "rationale_for_target"
    t.string   "data_contact_person"
    t.string   "person_reporting_data_to_bms"
    t.string   "notes"
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
    t.integer  "created_by_user_id"
    t.integer  "last_updated_by_user_id"
    t.string   "data_contact_person_email"
    t.string   "person_reporting_data_to_bms_email"
    t.string   "frequency_data_available"
  end

  add_index "performance_measures", ["measurable_type", "measurable_id"], name: "index_performance_measures_on_measurable_type_and_measurable_id", using: :btree

  create_table "rich_rich_files", force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "rich_file_file_name"
    t.string   "rich_file_content_type"
    t.integer  "rich_file_file_size"
    t.datetime "rich_file_updated_at"
    t.string   "owner_type"
    t.integer  "owner_id"
    t.text     "uri_cache"
    t.string   "simplified_type",        default: "file"
  end

  create_table "taggings", force: :cascade do |t|
    t.integer  "initiative_planning_guide_id", null: false
    t.integer  "tag_id",                       null: false
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  add_index "taggings", ["initiative_planning_guide_id"], name: "index_taggings_on_initiative_planning_guide_id", using: :btree
  add_index "taggings", ["tag_id"], name: "index_taggings_on_tag_id", using: :btree

  create_table "tags", force: :cascade do |t|
    t.string   "name",       null: false
    t.string   "use_case"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

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

  add_foreign_key "initiative_goal_outcomes", "initiative_planning_guides"
  add_foreign_key "initiative_humans", "initiative_planning_guides"
  add_foreign_key "initiative_linked_measures", "initiative_planning_guides"
  add_foreign_key "initiative_linked_measures", "performance_measures"
  add_foreign_key "initiative_plan_years", "initiative_planning_guides"
  add_foreign_key "initiative_planning_guides", "objectives"
  add_foreign_key "measure_reports", "performance_measures"
  add_foreign_key "objectives", "key_focus_areas"
  add_foreign_key "performance_factor_entries", "measure_reports"
  add_foreign_key "performance_factor_entries", "performance_factors"
  add_foreign_key "performance_factors", "performance_measures"
  add_foreign_key "taggings", "initiative_planning_guides"
  add_foreign_key "taggings", "tags"
end
