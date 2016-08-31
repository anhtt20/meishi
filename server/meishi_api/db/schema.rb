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

ActiveRecord::Schema.define(version: 20160823051748) do

  create_table "business_cards", primary_key: "business_card_id", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin" do |t|
    t.string   "name",          limit: 50
    t.string   "furigana",      limit: 50
    t.string   "email",         limit: 129,                 null: false
    t.string   "tel",           limit: 20
    t.integer  "owner_id"
    t.datetime "recieve_date"
    t.integer  "company_id"
    t.integer  "department_id"
    t.boolean  "deleted",                   default: false
    t.integer  "create_by"
    t.integer  "update_by"
    t.datetime "created_at",                                null: false
    t.datetime "updated_at",                                null: false
    t.integer  "comment_id"
    t.index ["business_card_id"], name: "index_business_cards_on_business_card_id", unique: true, using: :btree
  end

  create_table "comments", primary_key: "comment_id", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin" do |t|
    t.text     "content",    limit: 65535
    t.boolean  "deleted",                  default: false
    t.integer  "create_by"
    t.integer  "update_by"
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
  end

  create_table "companies", primary_key: "company_id", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin" do |t|
    t.string   "name",       limit: 150,                        null: false
    t.text     "address",    limit: 65535,                      null: false
    t.string   "email",      limit: 129
    t.string   "tel",        limit: 20
    t.string   "fax",        limit: 20
    t.string   "url",        limit: 150
    t.boolean  "deleted",                  default: false
    t.integer  "create_by"
    t.integer  "update_by"
    t.datetime "created_at",                                    null: false
    t.datetime "updated_at",                                    null: false
    t.string   "post_code",  limit: 8,     default: "000-0000", null: false
  end

  create_table "departments", primary_key: "department_id", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin" do |t|
    t.string   "name",       limit: 50,                 null: false
    t.boolean  "deleted",               default: false
    t.integer  "create_by"
    t.integer  "update_by"
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
  end

  create_table "file_locations", id: false, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin" do |t|
    t.string   "file_type",        limit: 3,   default: "OMT", null: false
    t.integer  "business_card_id",                             null: false
    t.string   "path",             limit: 500,                 null: false
    t.string   "domain",           limit: 500,                 null: false
    t.boolean  "deleted",                      default: false
    t.integer  "create_by"
    t.integer  "update_by"
    t.datetime "created_at",                                   null: false
    t.datetime "updated_at",                                   null: false
    t.index ["file_type", "business_card_id"], name: "index_file_locations_on_file_type_and_business_card_id", unique: true, using: :btree
  end

  create_table "map_comments", id: false, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin" do |t|
    t.integer  "comment_id",                       null: false
    t.integer  "business_card_id",                 null: false
    t.boolean  "deleted",          default: false
    t.integer  "create_by"
    t.integer  "update_by"
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.index ["comment_id", "business_card_id"], name: "index_map_comments_on_comment_id_and_business_card_id", unique: true, using: :btree
  end

  create_table "map_roles", id: false, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin" do |t|
    t.integer  "role_id",                    null: false
    t.integer  "user_id",                    null: false
    t.boolean  "deleted",    default: false
    t.integer  "create_by"
    t.integer  "update_by"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.index ["role_id", "user_id"], name: "index_map_roles_on_role_id_and_user_id", unique: true, using: :btree
  end

  create_table "map_tags", id: false, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin" do |t|
    t.integer  "tag_id",                           null: false
    t.integer  "business_card_id",                 null: false
    t.boolean  "deleted",          default: false
    t.integer  "create_by"
    t.integer  "update_by"
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.index ["tag_id", "business_card_id"], name: "index_map_tags_on_tag_id_and_business_card_id", unique: true, using: :btree
  end

  create_table "roles", primary_key: "role_id", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin" do |t|
    t.string   "role_name",  limit: 10,                 null: false
    t.boolean  "deleted",               default: false
    t.integer  "create_by"
    t.integer  "update_by"
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
  end

  create_table "tags", primary_key: "tag_id", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin" do |t|
    t.string   "name",       limit: 30,                 null: false
    t.boolean  "deleted",               default: false
    t.integer  "create_by"
    t.integer  "update_by"
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
  end

  create_table "tokens", primary_key: "user_id", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin" do |t|
    t.string   "token",        limit: 60, null: false
    t.string   "expired_time", limit: 10, null: false
    t.integer  "create_by"
    t.integer  "update_by"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "users", primary_key: "user_id", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin" do |t|
    t.string   "email",           limit: 129,                 null: false
    t.string   "password_digest", limit: 60,                  null: false
    t.boolean  "deleted",                     default: false
    t.integer  "create_by"
    t.integer  "update_by"
    t.datetime "created_at",                                  null: false
    t.datetime "updated_at",                                  null: false
  end

end
