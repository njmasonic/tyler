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

ActiveRecord::Schema.define(:version => 20120131134634) do

  create_table "api_keys", :force => true do |t|
    t.string   "key"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "api_keys", ["key"], :name => "index_api_keys_on_key"

  create_table "authorizations", :force => true do |t|
    t.string   "code"
    t.text     "properties"
    t.integer  "created_by_api_key_id"
    t.datetime "created_at",            :null => false
    t.datetime "updated_at",            :null => false
  end

  add_index "authorizations", ["code"], :name => "index_authorizations_on_code"

  create_table "consumers", :force => true do |t|
    t.string   "name"
    t.string   "return_url"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "registrations", :force => true do |t|
    t.integer "user_id"
    t.integer "authorization_id"
    t.string  "code"
    t.text    "properties"
  end

  add_index "registrations", ["authorization_id"], :name => "index_registrations_on_authorization_id"
  add_index "registrations", ["user_id"], :name => "index_registrations_on_user_id"

  create_table "tokens", :force => true do |t|
    t.string   "token"
    t.integer  "user_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.integer  "consumer_id"
  end

  add_index "tokens", ["consumer_id", "user_id"], :name => "index_tokens_on_consumer_id_and_user_id"
  add_index "tokens", ["token"], :name => "index_tokens_on_token"

  create_table "users", :force => true do |t|
    t.string   "email"
    t.datetime "created_at",                        :null => false
    t.datetime "updated_at",                        :null => false
    t.string   "encrypted_password", :limit => 128
    t.string   "salt",               :limit => 128
    t.string   "confirmation_token", :limit => 128
    t.string   "remember_token",     :limit => 128
  end

  add_index "users", ["email"], :name => "index_users_on_email"
  add_index "users", ["remember_token"], :name => "index_users_on_remember_token"

end
