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

ActiveRecord::Schema.define(version: 2018_08_31_232556) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "hstore"
  enable_extension "plpgsql"

  create_table "clients", force: :cascade do |t|
    t.string "name"
    t.bigint "fb_ad_account_id"
    t.string "ga_ad_account_id"
    t.integer "fb_dollar_conv", default: 1, null: false
    t.integer "ga_dollar_conv", default: 1, null: false
    t.string "main_color"
    t.boolean "is_enabled", default: true
    t.datetime "last_update"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "clients_users", id: false, force: :cascade do |t|
    t.bigint "client_id", null: false
    t.bigint "user_id", null: false
    t.index ["client_id", "user_id"], name: "index_clients_users_on_client_id_and_user_id"
    t.index ["user_id", "client_id"], name: "index_clients_users_on_user_id_and_client_id"
  end

  create_table "fb_ads", id: :bigint, default: nil, force: :cascade do |t|
    t.string "name"
    t.string "bid_type"
    t.decimal "bid_amount", precision: 12, scale: 2, default: "0.0", null: false
    t.datetime "created_time"
    t.datetime "updated_time"
    t.string "status"
    t.bigint "source_ad_id"
    t.bigint "fb_adset_id"
    t.bigint "fb_campaign_id"
    t.bigint "client_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["client_id"], name: "index_fb_ads_on_client_id"
    t.index ["fb_adset_id"], name: "index_fb_ads_on_fb_adset_id"
    t.index ["fb_campaign_id"], name: "index_fb_ads_on_fb_campaign_id"
  end

  create_table "fb_adsets", id: :bigint, default: nil, force: :cascade do |t|
    t.string "name"
    t.string "bid_strategy"
    t.string "destination_type"
    t.string "billing_event"
    t.string "optimization_goal"
    t.bigint "instagram_actor_id"
    t.decimal "lifetime_budget", precision: 12, scale: 2, default: "0.0"
    t.decimal "daily_budget", precision: 12, scale: 2, default: "0.0"
    t.decimal "budget_remaining", precision: 12, scale: 2, default: "0.0"
    t.decimal "bid_amount", precision: 12, scale: 2, default: "0.0"
    t.datetime "created_time"
    t.datetime "updated_time"
    t.string "status"
    t.bigint "source_adset_id"
    t.bigint "fb_campaign_id"
    t.bigint "client_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["client_id"], name: "index_fb_adsets_on_client_id"
    t.index ["fb_campaign_id"], name: "index_fb_adsets_on_fb_campaign_id"
  end

  create_table "fb_campaign_insights", force: :cascade do |t|
    t.string "objective"
    t.decimal "spend", precision: 12, scale: 2, default: "0.0", null: false
    t.integer "impressions", default: 0, null: false
    t.integer "reach", default: 0, null: false
    t.decimal "cpc", precision: 8, scale: 3, default: "0.0", null: false
    t.decimal "cpc_uniq", precision: 8, scale: 3, default: "0.0", null: false
    t.decimal "ctr", precision: 8, scale: 3, default: "0.0", null: false
    t.decimal "ctr_uniq", precision: 8, scale: 3, default: "0.0", null: false
    t.integer "clicks", default: 0, null: false
    t.integer "clicks_uniq", default: 0, null: false
    t.decimal "frequency", precision: 8, scale: 3, default: "0.0", null: false
    t.jsonb "actions", default: {}, null: false
    t.jsonb "video_watched", default: {"n_p10"=>0, "n_p50"=>0, "n_p100"=>0, "avg_pct"=>0, "avg_time"=>0}, null: false
    t.date "date_start"
    t.date "date_stop"
    t.bigint "fb_campaign_id"
    t.bigint "client_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["client_id"], name: "index_fb_campaign_insights_on_client_id"
    t.index ["date_start"], name: "index_fb_campaign_insights_on_date_start"
    t.index ["date_stop"], name: "index_fb_campaign_insights_on_date_stop"
    t.index ["fb_campaign_id"], name: "index_fb_campaign_insights_on_fb_campaign_id"
  end

  create_table "fb_campaign_labels", force: :cascade do |t|
    t.bigint "fb_label_id"
    t.integer "dollar_conv", default: 1
    t.bigint "label_id"
    t.bigint "fb_campaign_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["fb_campaign_id"], name: "index_fb_campaign_labels_on_fb_campaign_id"
    t.index ["label_id"], name: "index_fb_campaign_labels_on_label_id"
  end

  create_table "fb_campaigns", id: :bigint, default: nil, force: :cascade do |t|
    t.string "name"
    t.string "bid_strategy"
    t.bigint "boosted_object_id"
    t.string "objective"
    t.decimal "lifetime_budget", precision: 12, scale: 2, default: "0.0", null: false
    t.decimal "budget_remaining", precision: 12, scale: 2, default: "0.0", null: false
    t.decimal "spend_cap", precision: 12, scale: 2, default: "0.0", null: false
    t.boolean "can_use_spend_cap"
    t.datetime "start_time"
    t.datetime "stop_time"
    t.datetime "created_time"
    t.datetime "updated_time"
    t.string "status"
    t.string "effective_status"
    t.bigint "source_campaign_id"
    t.bigint "client_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["client_id"], name: "index_fb_campaigns_on_client_id"
  end

  create_table "ga_campaign_insights", force: :cascade do |t|
    t.date "date"
    t.decimal "cost", precision: 12, scale: 2, default: "0.0", null: false
    t.integer "clicks", default: 0, null: false
    t.integer "impressions", default: 0, null: false
    t.decimal "ctr", precision: 5, scale: 2, default: "0.0", null: false
    t.integer "conversions", default: 0, null: false
    t.decimal "cost_per_conv", precision: 12, scale: 2, default: "0.0", null: false
    t.integer "engagements", default: 0, null: false
    t.decimal "bounce_rate", precision: 5, scale: 2, default: "0.0", null: false
    t.bigint "ga_campaign_id"
    t.bigint "client_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["client_id"], name: "index_ga_campaign_insights_on_client_id"
    t.index ["date"], name: "index_ga_campaign_insights_on_date"
    t.index ["ga_campaign_id"], name: "index_ga_campaign_insights_on_ga_campaign_id"
  end

  create_table "ga_campaign_labels", force: :cascade do |t|
    t.bigint "ga_label_id"
    t.integer "dollar_conv", default: 1
    t.bigint "label_id"
    t.bigint "ga_campaign_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ga_campaign_id"], name: "index_ga_campaign_labels_on_ga_campaign_id"
    t.index ["label_id"], name: "index_ga_campaign_labels_on_label_id"
  end

  create_table "ga_campaigns", id: :bigint, default: nil, force: :cascade do |t|
    t.string "name"
    t.string "status"
    t.date "start_date"
    t.date "end_date"
    t.decimal "budget_amount", precision: 10, scale: 2, default: "0.0", null: false
    t.string "ad_serving_optimization_status"
    t.string "advertising_channel_type"
    t.string "advertising_channel_subtype"
    t.jsonb "frequency_cap", default: {}, null: false
    t.jsonb "settings", default: {}, null: false
    t.bigint "client_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["client_id"], name: "index_ga_campaigns_on_client_id"
  end

  create_table "job_notifications", force: :cascade do |t|
    t.bigint "user_id"
    t.integer "recipient_id"
    t.string "action"
    t.string "notifiable_type"
    t.integer "notifiable_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_job_notifications_on_user_id"
  end

  create_table "label_budgets", force: :cascade do |t|
    t.integer "budget", default: 0
    t.date "period_start"
    t.date "period_end"
    t.bigint "label_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["label_id"], name: "index_label_budgets_on_label_id"
    t.index ["period_end"], name: "index_label_budgets_on_period_end"
    t.index ["period_start"], name: "index_label_budgets_on_period_start"
  end

  create_table "labels", force: :cascade do |t|
    t.string "name"
    t.bigint "client_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["client_id"], name: "index_labels_on_client_id"
    t.index ["name"], name: "index_labels_on_name"
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
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["provider"], name: "index_users_on_provider"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["uid"], name: "index_users_on_uid"
  end

  add_foreign_key "fb_ads", "clients"
  add_foreign_key "fb_ads", "fb_adsets"
  add_foreign_key "fb_ads", "fb_campaigns"
  add_foreign_key "fb_adsets", "clients"
  add_foreign_key "fb_adsets", "fb_campaigns"
  add_foreign_key "fb_campaign_insights", "clients"
  add_foreign_key "fb_campaign_insights", "fb_campaigns"
  add_foreign_key "fb_campaign_labels", "fb_campaigns"
  add_foreign_key "fb_campaign_labels", "labels"
  add_foreign_key "fb_campaigns", "clients"
  add_foreign_key "ga_campaign_insights", "clients"
  add_foreign_key "ga_campaign_insights", "ga_campaigns"
  add_foreign_key "ga_campaign_labels", "ga_campaigns"
  add_foreign_key "ga_campaign_labels", "labels"
  add_foreign_key "ga_campaigns", "clients"
  add_foreign_key "job_notifications", "users"
  add_foreign_key "label_budgets", "labels"
  add_foreign_key "labels", "clients"
end
