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

ActiveRecord::Schema.define(:version => 20091110204750) do

  create_table "avatars", :force => true do |t|
    t.integer  "user_id",      :limit => 11
    t.integer  "parent_id",    :limit => 11
    t.string   "content_type"
    t.string   "filename"
    t.string   "thumbnail"
    t.integer  "size",         :limit => 11
    t.integer  "width",        :limit => 11
    t.integer  "height",       :limit => 11
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "comments", :force => true do |t|
    t.integer "user_id",    :limit => 11, :null => false
    t.text    "body",                     :null => false
    t.integer "parent_id",  :limit => 11, :null => false
    t.date    "created_at",               :null => false
    t.date    "updated_at"
  end

  create_table "discussions", :force => true do |t|
    t.string   "text"
    t.integer  "parent",     :limit => 11
    t.string   "subject"
    t.boolean  "locked"
    t.integer  "order",      :limit => 11
    t.boolean  "public"
    t.integer  "user_id",    :limit => 11
    t.integer  "topic_id",   :limit => 11
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "followcount", :force => true do |t|
    t.integer "followtype_id", :limit => 11
    t.integer "count",         :limit => 11
    t.string  "follow_Type"
  end

  create_table "notifications", :force => true do |t|
    t.string "title"
  end

  create_table "notifications_users", :id => false, :force => true do |t|
    t.integer "user_id",         :limit => 11
    t.integer "notification_id", :limit => 11
  end

  create_table "profiles", :force => true do |t|
    t.string   "about"
    t.string   "contact1"
    t.string   "contact2"
    t.string   "contact3"
    t.integer  "user_id",    :limit => 11
    t.string   "city"
    t.string   "state"
    t.string   "country"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "questions", :force => true do |t|
    t.integer  "user_id",      :limit => 11
    t.string   "headline"
    t.text     "body"
    t.datetime "locked"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "topic_id",     :limit => 11
    t.integer  "parentid",     :limit => 11
    t.integer  "correct_flag", :limit => 11, :default => 0
  end

  add_index "questions", ["headline", "body"], :name => "fulltextindex"

  create_table "ratings", :force => true do |t|
    t.integer  "rating",        :limit => 11, :default => 0
    t.datetime "created_at",                                  :null => false
    t.string   "rateable_type", :limit => 15, :default => "", :null => false
    t.integer  "rateable_id",   :limit => 11, :default => 0,  :null => false
    t.integer  "user_id",       :limit => 11, :default => 0,  :null => false
    t.integer  "questionid",    :limit => 11
  end

  add_index "ratings", ["user_id"], :name => "fk_ratings_user"

  create_table "scores", :force => true do |t|
    t.integer "user_id", :limit => 11
    t.integer "score",   :limit => 11
  end

  create_table "sessions", :force => true do |t|
    t.string   "login"
    t.string   "email"
    t.string   "crypted_password",          :limit => 40
    t.string   "salt",                      :limit => 40
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_token"
    t.datetime "remember_token_expires_at"
  end

  create_table "taggings", :force => true do |t|
    t.integer "tag_id",        :limit => 11, :null => false
    t.integer "taggable_id",   :limit => 11, :null => false
    t.string  "taggable_type",               :null => false
    t.date    "created_at",                  :null => false
  end

  create_table "tags", :force => true do |t|
    t.string "name", :null => false
  end

  create_table "topics", :force => true do |t|
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "login"
    t.string   "email"
    t.string   "crypted_password",          :limit => 40
    t.string   "salt",                      :limit => 40
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_token"
    t.datetime "remember_token_expires_at"
    t.boolean  "updates"
    t.string   "activation_code",           :limit => 40
    t.datetime "activated_at"
    t.string   "learnAbout"
    t.string   "mostExperienced"
    t.string   "veryExperienced"
    t.string   "kindOfExperienced"
    t.integer  "correct_flag",              :limit => 11, :default => 0,   :null => false
    t.integer  "login_count",               :limit => 11, :default => 0,   :null => false
    t.string   "resetcode",                               :default => "0", :null => false
    t.string   "identifier",                              :default => "0", :null => false
  end

end
