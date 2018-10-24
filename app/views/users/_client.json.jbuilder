json.extract! client, :id, :name, :page_id, :fb_ad_account_id, :is_enabled, :main_color, :created_at, :updated_at
json.url client_url(client, format: :json)
