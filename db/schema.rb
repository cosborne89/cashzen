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

ActiveRecord::Schema.define(version: 20131003161731) do

  create_table "budgets", force: true do |t|
    t.string   "title"
    t.decimal  "remaining"
    t.integer  "month"
    t.integer  "year"
    t.text     "transaction_ids"
    t.integer  "category_id"
    t.integer  "user_id"
    t.decimal  "initial"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.date     "date"
  end

  create_table "categories", force: true do |t|
    t.string   "title"
    t.decimal  "monthly_spend"
    t.text     "transaction_ids"
    t.decimal  "net_cash"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.decimal  "initial_cash",    default: 0.0
    t.text     "budget_ids"
    t.string   "frequency"
    t.string   "classification"
    t.string   "need_type"
  end

  create_table "transactions", force: true do |t|
    t.string   "title"
    t.integer  "category_id"
    t.date     "date"
    t.decimal  "amount"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.text     "budget_id"
  end

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "provider"
    t.string   "uid"
    t.string   "username"
    t.string   "role"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "category_ids"
    t.text     "transaction_ids"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
