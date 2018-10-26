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

ActiveRecord::Schema.define(version: 2018_10_26_190818) do

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

  create_table "clients", force: :cascade do |t|
    t.string "name"
    t.bigint "fb_ad_account_id"
    t.string "ga_ad_account_id"
    t.integer "fb_dollar_conv", default: 1, null: false
    t.integer "ga_dollar_conv", default: 1, null: false
    t.string "main_color"
    t.boolean "is_enabled", default: true
    t.datetime "last_update"
  end

  create_table "clients_users", id: false, force: :cascade do |t|
    t.bigint "client_id", null: false
    t.bigint "user_id", null: false
    t.index ["client_id", "user_id"], name: "index_clients_users_on_client_id_and_user_id"
    t.index ["user_id", "client_id"], name: "index_clients_users_on_user_id_and_client_id"
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

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
