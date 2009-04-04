# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20090331125107) do

  create_table "cases", :force => true do |t|
    t.string   "content"
    t.integer  "aim"
    t.integer  "emergency"
    t.integer  "security"
    t.integer  "kind"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "departments", :force => true do |t|
    t.string   "code",       :limit => 10
    t.string   "name",       :limit => 40
    t.string   "manager",    :limit => 10
    t.string   "telephone",  :limit => 20
    t.string   "fax",        :limit => 20
    t.string   "email",      :limit => 50
    t.string   "address",    :limit => 120
    t.string   "remark",     :limit => 800
    t.integer  "creator"
    t.integer  "modifier"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "events", :force => true do |t|
    t.integer  "state",      :default => 0, :null => false
    t.datetime "timing",                    :null => false
    t.string   "title",                     :null => false
    t.string   "content",                   :null => false
    t.string   "type"
    t.integer  "aim"
    t.integer  "emergency"
    t.integer  "security"
    t.integer  "kind"
    t.string   "name"
    t.string   "phone"
    t.string   "mobile"
    t.integer  "sex"
    t.string   "email"
    t.string   "address"
    t.string   "callnumber",                :null => false
    t.string   "calltag"
    t.integer  "person_id"
    t.integer  "case_id"
    t.string   "creator"
    t.string   "modifier"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "histories", :force => true do |t|
    t.integer  "event_id"
    t.integer  "handle"
    t.integer  "department_id"
    t.date     "timeout"
    t.string   "responser"
    t.string   "reason"
    t.string   "remark"
    t.integer  "creator_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "people", :force => true do |t|
    t.string   "name"
    t.string   "phone"
    t.string   "mobile"
    t.integer  "sex"
    t.string   "email"
    t.string   "address"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "login"
    t.string   "crypted_password",          :limit => 40
    t.string   "salt",                      :limit => 40
    t.string   "remember_token"
    t.datetime "remember_token_expires_at"
    t.string   "realname"
    t.integer  "sex"
    t.integer  "department_id"
    t.string   "position"
    t.string   "telephone",                 :limit => 20
    t.string   "mobile",                    :limit => 20
    t.integer  "ismanager"
    t.string   "email",                     :limit => 120
    t.string   "remark",                    :limit => 20
    t.integer  "creator"
    t.integer  "modifier"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "workitems", :force => true do |t|
    t.string   "store_name",      :null => false
    t.integer  "event_id",        :null => false
    t.string   "creator",         :null => false
    t.string   "last_store_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
