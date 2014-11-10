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

ActiveRecord::Schema.define(version: 20141110080654) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "customers", force: true do |t|
    t.string   "name",       null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "days", force: true do |t|
    t.date     "date"
    t.boolean  "holiday",    default: true, null: false
    t.string   "reason"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "project_users", force: true do |t|
    t.integer  "project_id", null: false
    t.integer  "user_id",    null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "project_users", ["project_id", "user_id"], name: "index_project_users_on_project_id_and_user_id", unique: true, using: :btree
  add_index "project_users", ["project_id"], name: "index_project_users_on_project_id", using: :btree
  add_index "project_users", ["user_id"], name: "index_project_users_on_user_id", using: :btree

  create_table "projects", force: true do |t|
    t.string   "name",        null: false
    t.integer  "customer_id", null: false
    t.text     "description"
    t.integer  "rate_kopeks", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "projects", ["customer_id"], name: "index_projects_on_customer_id", using: :btree

  create_table "tasks", force: true do |t|
    t.integer  "user_id",                     null: false
    t.integer  "project_id",                  null: false
    t.string   "name",                        null: false
    t.text     "description"
    t.string   "url"
    t.date     "date",                        null: false
    t.boolean  "payable",     default: false, null: false
    t.integer  "status",      default: 0,     null: false
    t.integer  "task_type",   default: 0,     null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "tasks", ["project_id"], name: "index_tasks_on_project_id", using: :btree
  add_index "tasks", ["user_id"], name: "index_tasks_on_user_id", using: :btree

  create_table "time_entries", force: true do |t|
    t.integer  "task_id",     null: false
    t.text     "description"
    t.integer  "duration",    null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.date     "date",        null: false
  end

  add_index "time_entries", ["task_id"], name: "index_time_entries_on_task_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "email",                  default: "",           null: false
    t.string   "encrypted_password",     default: "",           null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,            null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "admin",                  default: false,        null: false
    t.string   "first_name",             default: "",           null: false
    t.string   "last_name",              default: "",           null: false
    t.date     "birth_date",             default: '2014-11-06', null: false
    t.integer  "position",               default: 0,            null: false
    t.date     "hire_date",              default: '2014-11-06', null: false
    t.date     "fire_date"
    t.integer  "salary_kopeks",          default: 0,            null: false
    t.integer  "official_salary_kopeks", default: 0,            null: false
    t.string   "inn"
    t.string   "snils"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
