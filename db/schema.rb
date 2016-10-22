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

ActiveRecord::Schema.define(version: 20160629090520) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "hstore"

  create_table "carts", force: :cascade do |t|
    t.integer  "member_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "carts", ["member_id"], name: "index_carts_on_member_id", using: :btree

  create_table "discounts", force: :cascade do |t|
    t.string   "name",          default: ""
    t.string   "key",           default: ""
    t.integer  "prerequisite",  default: 0
    t.integer  "discount_type", default: 0
    t.float    "factor",        default: 0.0
    t.date     "date_from",     default: '2016-10-22'
    t.date     "date_to",       default: '2016-10-22'
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
  end

  create_table "line_items", force: :cascade do |t|
    t.integer  "product_detail_id"
    t.integer  "cart_id"
    t.integer  "order_id"
    t.string   "name",                default: ""
    t.date     "birth"
    t.integer  "gender",              default: 0
    t.string   "ss_number",           default: ""
    t.string   "school",              default: ""
    t.integer  "grade",               default: 0
    t.integer  "food_preference",     default: 0
    t.string   "note",                default: ""
    t.string   "parent_phone_number", default: ""
    t.string   "parent_email",        default: ""
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
  end

  add_index "line_items", ["cart_id"], name: "index_line_items_on_cart_id", using: :btree
  add_index "line_items", ["order_id"], name: "index_line_items_on_order_id", using: :btree
  add_index "line_items", ["product_detail_id"], name: "index_line_items_on_product_detail_id", using: :btree

  create_table "members", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.string   "name"
    t.string   "avatar"
    t.string   "provider"
    t.string   "uid"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "members", ["email"], name: "index_members_on_email", unique: true, using: :btree
  add_index "members", ["reset_password_token"], name: "index_members_on_reset_password_token", unique: true, using: :btree

  create_table "orders", force: :cascade do |t|
    t.integer  "member_id"
    t.integer  "discount_id"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "address"
    t.integer  "payment",     default: 0
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  add_index "orders", ["discount_id"], name: "index_orders_on_discount_id", using: :btree
  add_index "orders", ["member_id"], name: "index_orders_on_member_id", using: :btree

  create_table "product_details", force: :cascade do |t|
    t.integer  "product_id"
    t.string   "description"
    t.string   "place"
    t.integer  "price"
    t.integer  "inventory"
    t.date     "date_from",   default: '2016-10-22'
    t.date     "date_to",     default: '2016-10-22'
    t.time     "time_from",   default: '2000-01-01 09:00:00'
    t.time     "time_to",     default: '2000-01-01 17:00:00'
    t.datetime "created_at",                                  null: false
    t.datetime "updated_at",                                  null: false
  end

  add_index "product_details", ["product_id"], name: "index_product_details_on_product_id", using: :btree

  create_table "products", force: :cascade do |t|
    t.string   "name"
    t.string   "subtitle"
    t.string   "cover_image_url"
    t.string   "outline_image_url"
    t.string   "dimension_image_url"
    t.text     "description"
    t.text     "dimension"
    t.text     "target"
    t.text     "pricing"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
  end

  create_table "transactions", force: :cascade do |t|
    t.integer  "order_id"
    t.hstore   "params"
    t.string   "trade_number"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "transactions", ["order_id"], name: "index_transactions_on_order_id", using: :btree
  add_index "transactions", ["trade_number"], name: "index_transactions_on_trade_number", unique: true, using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  add_foreign_key "carts", "members"
  add_foreign_key "line_items", "carts"
  add_foreign_key "line_items", "orders"
  add_foreign_key "line_items", "product_details"
  add_foreign_key "orders", "discounts"
  add_foreign_key "orders", "members"
  add_foreign_key "product_details", "products"
  add_foreign_key "transactions", "orders"
end
