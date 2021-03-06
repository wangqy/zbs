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

ActiveRecord::Schema.define(:version => 20090629081352) do

  create_table "conversations", :force => true do |t|
    t.integer  "state",       :limit => 2,   :default => 0,     :null => false
    t.string   "tag",         :limit => 20,                     :null => false
    t.string   "title",       :limit => 20,                     :null => false
    t.integer  "aim",         :limit => 2
    t.integer  "emergency",   :limit => 2
    t.integer  "security",    :limit => 2
    t.integer  "kind_id"
    t.string   "content",     :limit => 800,                    :null => false
    t.date     "finish_at",                                     :null => false
    t.integer  "creator_id",                                    :null => false
    t.integer  "modifier_id",                                   :null => false
    t.boolean  "delta",                      :default => false, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "departments", :force => true do |t|
    t.string   "name",           :limit => 40
    t.string   "manager",        :limit => 10
    t.string   "telephone",      :limit => 20
    t.string   "fax",            :limit => 20
    t.string   "address",        :limit => 120
    t.string   "remark",         :limit => 800
    t.integer  "creator_id"
    t.integer  "modifier_id"
    t.integer  "parent_id"
    t.string   "responsibility", :limit => 120
    t.integer  "lines"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "duties", :force => true do |t|
    t.string  "watchman", :limit => 10, :null => false
    t.string  "receiver", :limit => 10, :null => false
    t.string  "manager",  :limit => 10, :null => false
    t.integer "event_id"
  end

  create_table "events", :force => true do |t|
    t.datetime "timing",                         :null => false
    t.string   "content",         :limit => 800
    t.integer  "category",        :limit => 2,   :null => false
    t.integer  "record_id"
    t.integer  "creator_id",                     :null => false
    t.integer  "modifier_id",                    :null => false
    t.integer  "conversation_id",                :null => false
    t.integer  "person_id",                      :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "histories", :force => true do |t|
    t.integer  "conversation_id"
    t.integer  "handle"
    t.integer  "department_id"
    t.date     "timeout"
    t.integer  "user_id"
    t.string   "reason"
    t.string   "remark"
    t.integer  "creator_id",      :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "kinds", :force => true do |t|
    t.string   "name",       :limit => 20, :null => false
    t.integer  "days",                     :null => false
    t.integer  "parent_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "logged_exceptions", :force => true do |t|
    t.string   "exception_class"
    t.string   "controller_name"
    t.string   "action_name"
    t.text     "message"
    t.text     "backtrace"
    t.text     "environment"
    t.text     "request"
    t.datetime "created_at"
  end

  create_table "logs", :force => true do |t|
    t.integer  "operate"
    t.string   "modulename",  :limit => 10
    t.string   "content",     :limit => 120
    t.integer  "objectid"
    t.datetime "operatedate"
    t.string   "ip",          :limit => 15
    t.integer  "operator_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "messages", :force => true do |t|
    t.integer  "conversation_id",                    :null => false
    t.integer  "user_id",                            :null => false
    t.string   "content",                            :null => false
    t.integer  "creator_id",                         :null => false
    t.boolean  "is_sended",       :default => false, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "notices", :force => true do |t|
    t.string   "title",       :limit => 120
    t.string   "content",     :limit => 800
    t.integer  "deployed"
    t.integer  "creator_id"
    t.integer  "modifier_id"
    t.integer  "deployee_id"
    t.datetime "deployed_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "onlines", :force => true do |t|
    t.integer  "user_id"
    t.datetime "actived_at"
  end

  create_table "people", :force => true do |t|
    t.string   "name",        :limit => 20,  :null => false
    t.string   "mobile",      :limit => 20
    t.string   "cardno",      :limit => 20
    t.string   "phone",       :limit => 100
    t.integer  "sex",         :limit => 2
    t.string   "address",     :limit => 50
    t.string   "jobunit",     :limit => 50
    t.string   "email",       :limit => 50
    t.integer  "creator_id",                 :null => false
    t.integer  "modifier_id",                :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "permissions", :force => true do |t|
    t.integer "user_id"
    t.integer "resource_id"
  end

  create_table "records", :force => true do |t|
    t.integer  "kind",       :limit => 2,  :null => false
    t.string   "dail",       :limit => 15, :null => false
    t.string   "receive",    :limit => 15, :null => false
    t.string   "wavfile",    :limit => 32, :null => false
    t.string   "uniqueid",   :limit => 32, :null => false
    t.datetime "created_at",               :null => false
  end

  create_table "resources", :force => true do |t|
    t.string  "name",      :limit => 20,                :null => false
    t.string  "code",      :limit => 20,                :null => false
    t.string  "path",      :limit => 50
    t.string  "css",       :limit => 10
    t.integer "sequence",                :default => 0, :null => false
    t.integer "parent_id"
  end

  create_table "sequences", :force => true do |t|
    t.date    "day",                   :null => false
    t.integer "number", :default => 1, :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "login",                                                   :null => false
    t.string   "crypted_password",          :limit => 40
    t.string   "salt",                      :limit => 40
    t.string   "remember_token"
    t.datetime "remember_token_expires_at"
    t.string   "realname",                                                :null => false
    t.integer  "sex",                       :limit => 2
    t.integer  "department_id",                                           :null => false
    t.string   "position"
    t.string   "telephone",                 :limit => 20,                 :null => false
    t.string   "mobile",                    :limit => 20,                 :null => false
    t.string   "email",                     :limit => 120
    t.string   "remark",                    :limit => 20
    t.integer  "disabled",                  :limit => 2,   :default => 0
    t.integer  "site"
    t.integer  "creator"
    t.integer  "modifier"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "workitems", :force => true do |t|
    t.integer  "store_id",        :null => false
    t.integer  "conversation_id", :null => false
    t.integer  "creator_id",      :null => false
    t.integer  "last_store_id",   :null => false
    t.datetime "created_at",      :null => false
  end

end
