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

ActiveRecord::Schema.define(version: 20151125071353) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "articles", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "url"
    t.string   "description",             null: false
    t.text     "content"
    t.integer  "importance",  default: 5, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "title",                   null: false
  end

  add_index "articles", ["user_id"], name: "index_articles_on_user_id", using: :btree

  create_table "attaches", force: :cascade do |t|
    t.string   "title"
    t.string   "attachment"
    t.integer  "comment_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.integer  "user_id"
    t.integer  "attacheable_id"
    t.string   "attacheable_type"
  end

  add_index "attaches", ["attacheable_type", "attacheable_id"], name: "index_attaches_on_attacheable_type_and_attacheable_id", using: :btree
  add_index "attaches", ["comment_id"], name: "index_attaches_on_comment_id", using: :btree

  create_table "categories", force: :cascade do |t|
    t.string   "name"
    t.integer  "parent_id"
    t.integer  "lft",                        null: false
    t.integer  "rgt",                        null: false
    t.integer  "depth",          default: 0, null: false
    t.integer  "children_count", default: 0, null: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  add_index "categories", ["lft"], name: "index_categories_on_lft", using: :btree
  add_index "categories", ["parent_id"], name: "index_categories_on_parent_id", using: :btree
  add_index "categories", ["rgt"], name: "index_categories_on_rgt", using: :btree

  create_table "comments", force: :cascade do |t|
    t.integer  "project_id",                 null: false
    t.string   "title",                      null: false
    t.text     "info",                       null: false
    t.boolean  "encrypted",  default: false, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "form",       default: 0
    t.integer  "user_id"
  end

  add_index "comments", ["project_id"], name: "index_comments_on_project_id", using: :btree

  create_table "common_comments", force: :cascade do |t|
    t.string   "title",            limit: 50, default: ""
    t.text     "comment"
    t.integer  "commentable_id"
    t.string   "commentable_type"
    t.integer  "user_id"
    t.string   "role",                        default: "comments"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "common_comments", ["commentable_id"], name: "index_common_comments_on_commentable_id", using: :btree
  add_index "common_comments", ["commentable_type"], name: "index_common_comments_on_commentable_type", using: :btree
  add_index "common_comments", ["user_id"], name: "index_common_comments_on_user_id", using: :btree

  create_table "contacts", force: :cascade do |t|
    t.integer  "customer_id"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "mobile"
    t.string   "skype"
    t.string   "email"
    t.text     "describe"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "contacts", ["customer_id"], name: "index_contacts_on_customer_id", using: :btree

  create_table "customers", force: :cascade do |t|
    t.string   "name",       null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "subject"
    t.integer  "profile"
    t.string   "source"
    t.text     "describe"
    t.string   "url"
  end

  create_table "days", force: :cascade do |t|
    t.date     "date"
    t.boolean  "holiday",    default: true, null: false
    t.string   "reason"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "days", ["date"], name: "index_days_on_date", using: :btree
  add_index "days", ["holiday"], name: "index_days_on_holiday", using: :btree

  create_table "project_users", force: :cascade do |t|
    t.integer  "project_id", null: false
    t.integer  "user_id",    null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "project_users", ["project_id", "user_id"], name: "index_project_users_on_project_id_and_user_id", unique: true, using: :btree
  add_index "project_users", ["project_id"], name: "index_project_users_on_project_id", using: :btree
  add_index "project_users", ["user_id"], name: "index_project_users_on_user_id", using: :btree

  create_table "projects", force: :cascade do |t|
    t.string   "name",                    null: false
    t.integer  "customer_id",             null: false
    t.text     "description"
    t.integer  "rate_kopeks",             null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "pivotal_id"
    t.integer  "state",       default: 0
  end

  add_index "projects", ["customer_id"], name: "index_projects_on_customer_id", using: :btree

  create_table "related_tasks", force: :cascade do |t|
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

  add_index "related_tasks", ["project_id"], name: "index_related_tasks_on_project_id", using: :btree
  add_index "related_tasks", ["user_id"], name: "index_related_tasks_on_user_id", using: :btree

  create_table "suggestion_box_comments", force: :cascade do |t|
    t.string   "title",            limit: 50, default: ""
    t.text     "comment"
    t.integer  "commentable_id"
    t.string   "commentable_type"
    t.integer  "user_id"
    t.string   "role",                        default: "comments"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "suggestion_box_comments", ["commentable_id"], name: "index_suggestion_box_comments_on_commentable_id", using: :btree
  add_index "suggestion_box_comments", ["commentable_type"], name: "index_suggestion_box_comments_on_commentable_type", using: :btree
  add_index "suggestion_box_comments", ["user_id"], name: "index_suggestion_box_comments_on_user_id", using: :btree

  create_table "suggestion_box_suggestions", force: :cascade do |t|
    t.string   "title"
    t.text     "text"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean  "anonymous"
  end

  create_table "taggings", force: :cascade do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context",       limit: 128
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true, using: :btree
  add_index "taggings", ["taggable_id", "taggable_type", "context"], name: "index_taggings_on_taggable_id_and_taggable_type_and_context", using: :btree

  create_table "tags", force: :cascade do |t|
    t.string  "name"
    t.integer "taggings_count", default: 0
  end

  add_index "tags", ["name"], name: "index_tags_on_name", unique: true, using: :btree

  create_table "time_entries", force: :cascade do |t|
    t.integer  "related_task_id", null: false
    t.text     "description"
    t.float    "duration",        null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.date     "date",            null: false
    t.float    "delivered_time"
  end

  add_index "time_entries", ["related_task_id"], name: "index_time_entries_on_related_task_id", using: :btree

  create_table "user_articles", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "article_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: :cascade do |t|
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
    t.date     "birth_date",             default: '2015-11-25', null: false
    t.integer  "position",               default: 0,            null: false
    t.date     "hire_date",              default: '2015-11-25', null: false
    t.date     "fire_date"
    t.integer  "salary_kopeks",          default: 0,            null: false
    t.integer  "official_salary_kopeks", default: 0,            null: false
    t.string   "inn"
    t.string   "snils"
    t.string   "pivotal_token"
    t.string   "google_token"
    t.string   "mobile"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "votes", force: :cascade do |t|
    t.integer  "votable_id"
    t.string   "votable_type"
    t.integer  "voter_id"
    t.string   "voter_type"
    t.boolean  "vote_flag"
    t.string   "vote_scope"
    t.integer  "vote_weight"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "votes", ["votable_id", "votable_type", "vote_scope"], name: "index_votes_on_votable_id_and_votable_type_and_vote_scope", using: :btree
  add_index "votes", ["voter_id", "voter_type", "vote_scope"], name: "index_votes_on_voter_id_and_voter_type_and_vote_scope", using: :btree

  create_table "wiki_page_versions", force: :cascade do |t|
    t.integer  "page_id",    null: false
    t.integer  "updator_id"
    t.integer  "number"
    t.string   "comment"
    t.string   "path"
    t.string   "title"
    t.text     "content"
    t.datetime "updated_at"
  end

  add_index "wiki_page_versions", ["page_id"], name: "index_wiki_page_versions_on_page_id", using: :btree
  add_index "wiki_page_versions", ["updator_id"], name: "index_wiki_page_versions_on_updator_id", using: :btree

  create_table "wiki_pages", force: :cascade do |t|
    t.integer  "creator_id"
    t.integer  "updator_id"
    t.string   "path"
    t.string   "title"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "category_id"
  end

  add_index "wiki_pages", ["creator_id"], name: "index_wiki_pages_on_creator_id", using: :btree
  add_index "wiki_pages", ["path"], name: "index_wiki_pages_on_path", unique: true, using: :btree

  add_foreign_key "attaches", "comments"
  add_foreign_key "contacts", "customers"
end
