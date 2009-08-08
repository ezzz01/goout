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

ActiveRecord::Schema.define(:version => 20090808103253) do

  create_table "blog_posts", :force => true do |t|
    t.string   "title"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "blogs", :force => true do |t|
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  create_table "comments", :force => true do |t|
    t.integer  "blog_post_id"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "globalize_countries", :force => true do |t|
    t.string "code",                   :limit => 2
    t.string "english_name"
    t.string "date_format"
    t.string "currency_format"
    t.string "currency_code",          :limit => 3
    t.string "thousands_sep",          :limit => 2
    t.string "decimal_sep",            :limit => 2
    t.string "currency_decimal_sep",   :limit => 2
    t.string "number_grouping_scheme"
  end

  add_index "globalize_countries", ["code"], :name => "index_globalize_countries_on_code"

  create_table "globalize_languages", :force => true do |t|
    t.string  "iso_639_1",             :limit => 2
    t.string  "iso_639_2",             :limit => 3
    t.string  "iso_639_3",             :limit => 3
    t.string  "rfc_3066"
    t.string  "english_name"
    t.string  "english_name_locale"
    t.string  "english_name_modifier"
    t.string  "native_name"
    t.string  "native_name_locale"
    t.string  "native_name_modifier"
    t.boolean "macro_language"
    t.string  "direction"
    t.string  "pluralization"
    t.string  "scope",                 :limit => 1
  end

  add_index "globalize_languages", ["iso_639_1"], :name => "index_globalize_languages_on_iso_639_1"
  add_index "globalize_languages", ["iso_639_2"], :name => "index_globalize_languages_on_iso_639_2"
  add_index "globalize_languages", ["iso_639_3"], :name => "index_globalize_languages_on_iso_639_3"
  add_index "globalize_languages", ["rfc_3066"], :name => "index_globalize_languages_on_rfc_3066"

  create_table "globalize_translations", :force => true do |t|
    t.string  "type"
    t.string  "tr_key"
    t.string  "table_name"
    t.integer "item_id"
    t.string  "facet"
    t.boolean "built_in",            :default => true
    t.integer "language_id"
    t.integer "pluralization_index"
    t.text    "text"
    t.string  "namespace"
  end

  add_index "globalize_translations", ["table_name", "item_id", "language_id"], :name => "globalize_translations_table_name_and_item_and_language"
  add_index "globalize_translations", ["tr_key", "language_id"], :name => "index_globalize_translations_on_tr_key_and_language_id"

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :default => "", :null => false
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

  create_table "users", :force => true do |t|
    t.string   "username"
    t.string   "password"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "authorization_token"
    t.integer  "blog_id"
  end

end
