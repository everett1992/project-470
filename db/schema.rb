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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130505203008) do

  create_table "bill_payments", :force => true do |t|
    t.integer  "user_id"
    t.integer  "bill_id"
    t.float    "amount"
    t.string   "method"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "bill_payments", ["bill_id"], :name => "index_bill_payments_on_bill_id"
  add_index "bill_payments", ["user_id"], :name => "index_bill_payments_on_user_id"

  create_table "bills", :force => true do |t|
    t.string   "name"
    t.string   "owed_to"
    t.float    "amount"
    t.date     "date_due"
    t.string   "status"
    t.integer  "dwelling_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.integer  "owner_id"
  end

  add_index "bills", ["date_due"], :name => "index_bills_on_date_due"
  add_index "bills", ["dwelling_id"], :name => "index_bills_on_dwelling_id"

  create_table "chores", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "assigned_user_id"
    t.integer  "dwelling_id"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
    t.integer  "owner_id"
    t.boolean  "active"
    t.string   "cron_str"
  end

  add_index "chores", ["assigned_user_id"], :name => "index_chores_on_assigned_user_id"
  add_index "chores", ["dwelling_id"], :name => "index_chores_on_dwelling_id"

  create_table "dwellings", :force => true do |t|
    t.string   "name"
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
    t.integer  "owner_id"
    t.string   "time_zone",  :default => "UTC"
    t.string   "topic_arn"
  end

  add_index "dwellings", ["owner_id"], :name => "index_dwellings_on_owner_id"

  create_table "events", :force => true do |t|
    t.integer  "dwelling_id"
    t.integer  "owner_id"
    t.string   "name"
    t.text     "description"
    t.datetime "date"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "events", ["date"], :name => "index_events_on_date"
  add_index "events", ["dwelling_id"], :name => "index_events_on_dwelling_id"
  add_index "events", ["owner_id"], :name => "index_events_on_user_id"

  create_table "invites", :force => true do |t|
    t.string   "token"
    t.string   "email"
    t.integer  "dwelling_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "invites", ["dwelling_id"], :name => "index_invites_on_dwelling_id"
  add_index "invites", ["token"], :name => "index_invites_on_token"

  create_table "messages", :force => true do |t|
    t.string   "body"
    t.integer  "dwelling_id"
    t.integer  "owner_id"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
    t.string   "type"
    t.integer  "dwelling_item_id"
    t.string   "dwelling_item_type"
  end

  add_index "messages", ["dwelling_id"], :name => "index_messages_on_dwelling_id"
  add_index "messages", ["dwelling_item_id"], :name => "index_messages_on_dwelling_item_id"
  add_index "messages", ["dwelling_item_type"], :name => "index_messages_on_dwelling_item_type"

  create_table "shopping_list_items", :force => true do |t|
    t.string   "name"
    t.integer  "quantity"
    t.integer  "obligate_id"
    t.integer  "obligates"
    t.boolean  "status"
    t.integer  "shopping_list_id"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
    t.integer  "owner_id"
  end

  add_index "shopping_list_items", ["shopping_list_id"], :name => "index_shopping_list_items_on_shopping_list_id"

  create_table "shopping_lists", :force => true do |t|
    t.string   "name"
    t.integer  "dwelling_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.integer  "owner_id"
  end

  add_index "shopping_lists", ["dwelling_id"], :name => "index_shopping_lists_on_dwelling_id"

  create_table "users", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
    t.integer  "dwelling_id"
    t.string   "cellphone"
    t.string   "picture_filename"
  end

  add_index "users", ["dwelling_id"], :name => "index_users_on_dwelling_id"
  add_index "users", ["email"], :name => "index_users_on_email"

end
