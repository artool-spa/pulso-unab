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

ActiveRecord::Schema.define(version: 2018_10_26_135229) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "answers", force: :cascade do |t|
    t.boolean "have_solution"
    t.decimal "level_effort"
    t.text "descript_effort"
    t.decimal "level_executive"
    t.decimal "level_time_respond"
    t.string "income_channel"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "ticket_id"
    t.index ["ticket_id"], name: "index_answers_on_ticket_id"
  end

  create_table "mailers", force: :cascade do |t|
    t.text "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "ticket_id"
    t.index ["ticket_id"], name: "index_mailers_on_ticket_id"
  end

  create_table "people", force: :cascade do |t|
    t.text "first_name"
    t.text "last_name"
    t.text "rut"
    t.text "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tickets", force: :cascade do |t|
    t.decimal "case_number"
    t.boolean "have_answer"
    t.text "owner"
    t.text "author"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "person_id"
    t.text "career"
    t.text "faculty"
    t.text "campus"
    t.text "case_type"
    t.index ["person_id"], name: "index_tickets_on_person_id"
  end

end
