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

ActiveRecord::Schema.define(version: 20200226134512) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "bets", force: :cascade do |t|
    t.string   "label"
    t.float    "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "option_id"
    t.index ["option_id"], name: "index_bets_on_option_id", using: :btree
  end

  create_table "enetvents", force: :cascade do |t|
    t.string   "title"
    t.string   "sport"
    t.date     "date"
    t.integer  "enet_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "events", force: :cascade do |t|
    t.string   "sport"
    t.string   "title"
    t.string   "home"
    t.string   "away"
    t.date     "date"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "enetvent_id"
    t.index ["enetvent_id"], name: "index_events_on_enetvent_id", using: :btree
  end

  create_table "options", force: :cascade do |t|
    t.string   "label"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "event_id"
    t.index ["event_id"], name: "index_options_on_event_id", using: :btree
  end

  add_foreign_key "bets", "options"
  add_foreign_key "events", "enetvents"
  add_foreign_key "options", "events"
end
