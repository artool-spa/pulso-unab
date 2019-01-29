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

ActiveRecord::Schema.define(version: 2019_01_17_142018) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "answers", force: :cascade do |t|
    t.boolean "have_solution"
    t.integer "level_effort"
    t.string "descript_effort"
    t.integer "level_executive"
    t.integer "level_time_respond"
    t.string "income_channel"
    t.bigint "ticket_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
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
    t.bigint "ticket_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ticket_id"], name: "index_mailers_on_ticket_id"
  end

  create_table "map_fields", force: :cascade do |t|
    t.string "asking_key"
    t.integer "key"
  end

  create_table "people", force: :cascade do |t|
    t.string "contact_id"
    t.string "full_name"
    t.string "rut"
    t.string "phone"
    t.string "cellphone"
    t.string "email"
    t.string "career"
    t.string "campus"
    t.string "faculty"
    t.boolean "send_email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["campus"], name: "index_people_on_campus"
    t.index ["career"], name: "index_people_on_career"
    t.index ["cellphone"], name: "index_people_on_cellphone"
    t.index ["contact_id"], name: "index_people_on_contact_id"
    t.index ["email"], name: "index_people_on_email"
    t.index ["faculty"], name: "index_people_on_faculty"
    t.index ["phone"], name: "index_people_on_phone"
    t.index ["rut"], name: "index_people_on_rut"
    t.index ["send_email"], name: "index_people_on_send_email"
  end

  create_table "tickets", force: :cascade do |t|
    t.string "ticket_id"
    t.string "business_owner_unit"
    t.string "business_author_unit"
    t.string "created_by"
    t.string "owner_by"
    t.string "incident_id"
    t.string "income_channel"
    t.string "modify_by"
    t.string "case_phase"
    t.string "category"
    t.string "state"
    t.string "status"
    t.string "priority"
    t.string "case_type"
    t.datetime "created_time"
    t.datetime "updated_time"
    t.bigint "person_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["business_author_unit"], name: "index_tickets_on_business_author_unit"
    t.index ["business_owner_unit"], name: "index_tickets_on_business_owner_unit"
    t.index ["case_phase"], name: "index_tickets_on_case_phase"
    t.index ["case_type"], name: "index_tickets_on_case_type"
    t.index ["category"], name: "index_tickets_on_category"
    t.index ["created_time"], name: "index_tickets_on_created_time"
    t.index ["income_channel"], name: "index_tickets_on_income_channel"
    t.index ["person_id"], name: "index_tickets_on_person_id"
    t.index ["priority"], name: "index_tickets_on_priority"
    t.index ["state"], name: "index_tickets_on_state"
    t.index ["status"], name: "index_tickets_on_status"
    t.index ["ticket_id"], name: "index_tickets_on_ticket_id"
    t.index ["updated_time"], name: "index_tickets_on_updated_time"
  end

  create_table "users", force: :cascade do |t|
    t.string "name", default: ""
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.boolean "is_enabled", default: true, null: false
    t.boolean "is_admin", default: false, null: false
    t.string "provider"
    t.string "uid"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["provider"], name: "index_users_on_provider"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["uid"], name: "index_users_on_uid"
  end

end
