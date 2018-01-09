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

ActiveRecord::Schema.define(version: 20180108233536) do

  create_table "buttafly_legends", force: :cascade do |t|
    t.text "data"
    t.string "targetable_model"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "buttafly_mappings", force: :cascade do |t|
    t.integer "legend_id"
    t.integer "originable_id"
    t.string "originable_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["originable_id", "originable_type"], name: "index_buttafly_mappings_on_originable_id_and_originable_type"
  end

  create_table "buttafly_spreadsheets", force: :cascade do |t|
    t.string "name"
    t.string "flat_file"
    t.string "aasm_state"
    t.integer "uploader_id"
    t.datetime "imported_at"
    t.datetime "processed_at"
    t.integer "row_count"
    t.integer "mtime"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["aasm_state"], name: "index_buttafly_spreadsheets_on_aasm_state"
    t.index ["imported_at"], name: "index_buttafly_spreadsheets_on_imported_at"
    t.index ["name"], name: "index_buttafly_spreadsheets_on_name"
    t.index ["processed_at"], name: "index_buttafly_spreadsheets_on_processed_at"
    t.index ["uploader_id"], name: "index_buttafly_spreadsheets_on_uploader_id"
  end

  create_table "excel_sheets", force: :cascade do |t|
    t.string "name"
    t.string "flat_file"
    t.string "aasm_state"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "reviews", force: :cascade do |t|
    t.integer "rating"
    t.string "content"
    t.integer "reviewer_id"
    t.string "wine_id"
    t.string "integer"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "wineries", force: :cascade do |t|
    t.string "name"
    t.string "mission"
    t.string "history"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "wines", force: :cascade do |t|
    t.string "name"
    t.string "vintage"
    t.integer "winery_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
