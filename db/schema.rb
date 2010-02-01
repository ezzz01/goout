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

ActiveRecord::Schema.define(:version => 20100130214341) do

  create_table "activities", :force => true do |t|
    t.string   "type"
    t.integer  "user_id"
    t.integer  "organization_id"
    t.integer  "study_program_id"
    t.integer  "exchange_program_id"
    t.integer  "activity_area_id"
    t.date     "from"
    t.date     "to"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "current",             :default => false
  end

  create_table "activity_areas", :force => true do |t|
    t.string   "title"
    t.text     "description"
    t.boolean  "pending",     :default => true
    t.integer  "added_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "avatars", :force => true do |t|
    t.integer "user_id"
    t.integer "parent_id"
    t.integer "size"
    t.integer "width"
    t.integer "height"
    t.string  "content_type"
    t.string  "filename"
    t.string  "thumbnail"
  end

  create_table "comments", :force => true do |t|
    t.integer  "post_id"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  create_table "countries", :force => true do |t|
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "exchange_programs", :force => true do |t|
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "pending",    :default => true
    t.integer  "added_by"
  end

  create_table "friendships", :force => true do |t|
    t.integer  "user_id"
    t.integer  "friend_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "organizations", :force => true do |t|
    t.string   "type"
    t.string   "title"
    t.string   "city"
    t.integer  "country_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "pending",    :default => true
    t.integer  "added_by"
  end

  create_table "posts", :force => true do |t|
    t.string   "title"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.string   "cached_tag_list"
  end

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :null => false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

  create_table "specs", :force => true do |t|
    t.integer  "user_id",                    :null => false
    t.string   "first_name", :default => ""
    t.string   "last_name",  :default => ""
    t.date     "birthdate"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "study_programs", :force => true do |t|
    t.string   "title"
    t.integer  "subject_area_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "pending",         :default => true
    t.integer  "added_by"
  end

  create_table "subject_areas", :force => true do |t|
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "taggings", :force => true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id"], :name => "index_taggings_on_tag_id"
  add_index "taggings", ["taggable_id", "taggable_type"], :name => "index_taggings_on_taggable_id_and_taggable_type"

  create_table "tags", :force => true do |t|
    t.string "name"
  end

  create_table "users", :force => true do |t|
    t.string   "username"
    t.string   "password"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "authorization_token"
    t.string   "blog_url"
    t.string   "blog_type"
  end

end
