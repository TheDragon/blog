# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of ActiveRecord to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 3) do

  create_table "comments", :force => true do |t|
    t.string   "post_id",    :default => "NULL"
    t.text     "body",       :default => "NULL"
    t.string   "author",     :default => "NULL"
    t.string   "email",      :default => "NULL"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "posts", :force => true do |t|
    t.string   "title",      :default => "NULL"
    t.text     "body",       :default => "NULL"
    t.string   "permalink",  :default => "NULL"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "username",   :default => "NULL"
    t.string   "pass_hash",  :default => "NULL"
    t.boolean  "admin",      :default => false
    t.string   "email",      :default => "NULL"
    t.string   "salt",       :default => "NULL"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
