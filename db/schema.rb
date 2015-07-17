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

ActiveRecord::Schema.define(version: 20150715111435) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "companies", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.string "website"
  end

  add_index "companies", ["name"], name: "index_companies_on_name", unique: true, using: :btree

  create_table "locations", force: :cascade do |t|
    t.integer "company_id"
    t.string  "name"
    t.string  "website"
    t.string  "address"
    t.string  "city"
    t.string  "state"
    t.string  "zip"
    t.string  "country"
  end

  add_index "locations", ["company_id"], name: "index_locations_on_company_id", using: :btree

  create_table "products", force: :cascade do |t|
    t.string  "type"
    t.integer "company_id"
    t.string  "name"
    t.string  "custom_name"
    t.string  "category"
    t.string  "product_class"
    t.string  "product_type"
    t.jsonb   "custom_attrs"
  end

  add_index "products", ["company_id"], name: "index_products_on_company_id", using: :btree
  add_index "products", ["type"], name: "index_products_on_type", using: :btree

  create_table "quote_companies", force: :cascade do |t|
    t.integer  "quote_id"
    t.integer  "company_id"
    t.string   "offer_file_name"
    t.string   "offer_content_type"
    t.integer  "offer_file_size"
    t.datetime "offer_updated_at"
  end

  add_index "quote_companies", ["company_id"], name: "index_quote_companies_on_company_id", using: :btree
  add_index "quote_companies", ["quote_id"], name: "index_quote_companies_on_quote_id", using: :btree

  create_table "quotes", force: :cascade do |t|
    t.string   "number",     limit: 10
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  add_index "quotes", ["number"], name: "index_quotes_on_number", unique: true, using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "type"
    t.integer  "userable_id"
    t.string   "userable_type"
    t.string   "prefix"
    t.string   "first_name"
    t.string   "middle_name"
    t.string   "last_name"
    t.string   "suffix"
    t.string   "title"
    t.string   "phone",                  limit: 20
    t.string   "google_plus"
    t.string   "linked_in"
    t.string   "email",                             default: "", null: false
    t.string   "encrypted_password",                default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                     default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["type"], name: "index_users_on_type", using: :btree
  add_index "users", ["userable_type", "userable_id"], name: "index_users_on_userable_type_and_userable_id", using: :btree

  add_foreign_key "locations", "companies"
  add_foreign_key "products", "companies"
  add_foreign_key "quote_companies", "companies"
  add_foreign_key "quote_companies", "quotes"
end
