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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20160201191257) do

  create_table "buildings", force: :cascade do |t|
    t.string   "name"
    t.string   "address_line_1"
    t.string   "address_line_2"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "inspection_items", force: :cascade do |t|
    t.string   "name"
    t.decimal  "weight"
    t.integer  "position"
    t.string   "section"
    t.decimal  "score"
    t.text     "comment"
    t.string   "type"
    t.string   "status"
    t.integer  "inspection_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "inspection_template_items", force: :cascade do |t|
    t.string   "type"
    t.string   "section"
    t.decimal  "weight"
    t.integer  "position"
    t.integer  "inspection_template_id"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.string   "name"
  end

  create_table "inspection_templates", force: :cascade do |t|
    t.integer  "unit_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "name"
  end

  create_table "inspections", force: :cascade do |t|
    t.text     "description"
    t.integer  "unit_id"
    t.string   "status"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "units", force: :cascade do |t|
    t.integer  "building_id"
    t.string   "unit_number"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "units", ["building_id"], name: "index_units_on_building_id"

end
