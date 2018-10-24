require 'google/apis/sheets_v4'
require 'googleauth'
require 'google_ads_api'
include Google::Auth

$debug = true

namespace :clients do
  desc "Get Campaigns and insights"
  task :all, [:date_from, :date_to, :client_ids] => [:environment] do |t, args|
    date_curr = DateTime.current

    if !args.date_from.blank? && !args.date_to.blank?
      date_from = DateTime.parse(args.date_from)
      date_to = DateTime.parse(args.date_to)
    elsif args.date_from.to_s == 'daily'
      date_from = date_curr.yesterday
      date_to = date_curr
    else
      date_from = date_curr.beginning_of_month
      date_to = date_curr
    end

    fb_api = FbApi.new(fb_token: Rails.application.credentials.artoolbmu_ddmsem, app_id: "267538760497947", app_secret: "4d2e3ead31fd7865478d00e4403d8abc", limit: 25, debug_mode: -1)
    #fb_api = FbApi.new(fb_token: Rails.application.credentials.hiperjp_ddmsem, app_id: "267538760497947", app_secret: "4d2e3ead31fd7865478d00e4403d8abc", limit: 25, debug_mode: -1)

    puts ">> Processing clients:all between #{date_from.strftime("%Y-%m-%d")} and #{date_to.strftime("%Y-%m-%d")}, on #{DateTime.current.strftime("%F %T")}".colorize(:light_yellow)
    clients = Client.where(is_enabled: true)
    clients = clients.where(id: args.client_ids.split(";")) if !args.client_ids.blank?
    clients = clients.order(name: :asc)
    clients.each do |client|
      puts " - Client: #{client.name} (#{client.id}) | Ad Account ID: #{client.fb_ad_account_id}"

      if !client.fb_ad_account_id.blank? && client.fb_ad_account_id != 0
        # FbCampaigns
        puts "   Getting FbCampaigns on #{DateTime.current.strftime("%F %T")}"
        fba_campaigns = FbCampaign.get_from_fb(fb_api, client)
        puts "     Total: #{fba_campaigns[:total_counter]} (#{fba_campaigns[:pages_counter]}p)".colorize(:light_black)
        #exit(0)

        # FbAdsets
        puts "   Getting FbAdsets on #{DateTime.current.strftime("%F %T")}"
        fba_adsets = FbAdset.get_from_fb(fb_api, client)
        puts "     Total: #{fba_adsets[:total_counter]} (#{fba_adsets[:pages_counter]})p".colorize(:light_black)

        # FbAds
        # puts "   Getting FbAds on #{DateTime.current.strftime("%F %T")}"
        # fba_ads = FbAd.get_from_fb(fb_api, client)
        # puts "     Total: #{fba_ads[:total_counter]} (#{fba_ads[:pages_counter]}p)".colorize(:light_black)

        # Get FbCampaignInsights, date_preset: 'daily'
        puts "   Getting FbCampaignInsights on #{DateTime.current.strftime("%F %T")}"
        FbCampaignInsight.get_from_fb(fb_api, client, { time_range: { since: date_from.strftime("%F"), until: date_to.strftime("%F") }, time_increment: 1 })
      end

      if !client.ga_ad_account_id.blank?
        # Init GAds API
        gads_api = GoogleAdsApi.new(client_customer_id: client.ga_ad_account_id)

        # Get GaCampaigns
        puts "   Getting GaCampaigns on #{DateTime.current.strftime("%F %T")}"
        ga_campaigns = GaCampaign.get_from_ga(gads_api, client)
        puts "     Total: #{ga_campaigns[:total_counter]} (#{ga_campaigns[:pages_counter]}p)".colorize(:light_black)

        # Get GaCampaignInsights
        puts "   Getting GaCampaign Performance Report on #{DateTime.current.strftime("%F %T")}"
        GaCampaignInsight.get_from_ga(gads_api, client, { since: date_from.strftime("%Y%m%d"), until: date_to.strftime("%Y%m%d") })
      else
        puts "   No ga_ad_account_id defined for client".colorize(:light_yellow)
      end
      puts ""

      # Update client's last update
      client.last_update = DateTime.current
      client.save
    end

    puts "   Ending on #{DateTime.current.strftime("%F %T")}.".colorize(:light_yellow)
    puts ""
  end

  desc "Get Ad Campaigns, Ads and Leads for clients by it's Ad Accounts"
  task :fb, [:date_from, :date_to, :client_ids] => [:environment] do |t, args|
    fb_api = FbApi.new(fb_token: Rails.application.credentials.artoolbmu_ddmsem, app_id: "267538760497947", app_secret: "4d2e3ead31fd7865478d00e4403d8abc", limit: 25, debug_mode: -1)
    #fb_api = FbApi.new(fb_token: Rails.application.credentials.hiperjp_ddmsem, app_id: "267538760497947", app_secret: "4d2e3ead31fd7865478d00e4403d8abc", limit: 25, debug_mode: -1)

    date_curr = DateTime.current

    if !args.date_from.blank? && !args.date_to.blank?
      date_from = DateTime.parse(args.date_from)
      date_to = DateTime.parse(args.date_to)
    elsif args.date_from.to_s == 'daily'
      date_from = date_curr.yesterday
      date_to = date_curr
    else
      date_from = date_curr.beginning_of_month
      date_to = date_curr
    end

    puts ">> Processing clients:fb between #{date_from.strftime("%Y-%m-%d")} and #{date_to.strftime("%Y-%m-%d")}, on #{DateTime.current.strftime("%F %T")}".colorize(:light_yellow)

    clients = Client.where(is_enabled: true)
    clients = clients.where(id: args.client_ids.split(";")) if !args.client_ids.blank?
    clients = clients.where.not(fb_ad_account_id: 0)
    clients = clients.order(name: :asc)
    clients.each do |client|
      puts " - Client: #{client.name} (#{client.id}) | Ad Account ID: #{client.fb_ad_account_id}"

      # FbCampaigns
      puts "   Getting FbCampaigns on #{DateTime.current.strftime("%F %T")}"
      fba_campaigns = FbCampaign.get_from_fb(fb_api, client)
      puts "     Total: #{fba_campaigns[:total_counter]} (#{fba_campaigns[:pages_counter]}p)".colorize(:light_black)
      #exit(0)

      # FbAdsets
      puts "   Getting FbAdsets on #{DateTime.current.strftime("%F %T")}"
      fba_adsets = FbAdset.get_from_fb(fb_api, client)
      puts "     Total: #{fba_adsets[:total_counter]} (#{fba_adsets[:pages_counter]}p)".colorize(:light_black)

      # FbAds
      #puts "   Getting FbAds on #{DateTime.current.strftime("%F %T")}"
      #fba_ads = FbAd.get_from_fb(fb_api, client)
      #puts "     Total: #{fba_ads[:total_counter]} (#{fba_ads[:pages_counter]}p)".colorize(:light_black)

      # Get FbCampaignInsights, date_preset: 'daily'
      puts "   Getting FbCampaignInsights on #{DateTime.current.strftime("%F %T")}"
      FbCampaignInsight.get_from_fb(fb_api, client, { time_range: { since: date_from.strftime("%F"), until: date_to.strftime("%F") }, time_increment: 1 })
      puts ""
    end

    puts "   Ending on #{DateTime.current.strftime("%F %T")}.".colorize(:light_yellow)
    puts ""
  end

  desc "Get GA Campaigns and Reports"
  task :ga, [:date_from, :date_to, :client_ids] => [:environment] do |t, args|
    date_curr = DateTime.current

    if !args.date_from.blank? && !args.date_to.blank?
      date_from = DateTime.parse(args.date_from)
      date_to = DateTime.parse(args.date_to)
    elsif args.date_from.to_s == 'daily'
      date_from = date_curr.yesterday
      date_to = date_curr
    else
      date_from = date_curr.beginning_of_month
      date_to = date_curr
    end

    puts ">> Processing clients:ga between #{date_from.strftime("%Y-%m-%d")} and #{date_to.strftime("%Y-%m-%d")}, on #{DateTime.current.strftime("%F %T")}".colorize(:light_yellow)

    clients = Client.where(is_enabled: true)
    clients = clients.where(id: args.client_ids.split(";")) if !args.client_ids.blank?
    clients = clients.where.not(ga_ad_account_id: nil)
    clients = clients.order(name: :asc)
    clients.each do |client|
      puts " - Client: #{client.name} (#{client.id}) | GA Client ID: #{client.ga_ad_account_id}"

      # Init GAds API
      gads_api = GoogleAdsApi.new(client_customer_id: client.ga_ad_account_id) unless client.ga_ad_account_id.blank?

      if gads_api
        # Get GaCampaigns
        puts "   Getting Campaigns on #{DateTime.current.strftime("%F %T")}"
        ga_campaigns = GaCampaign.get_from_ga(gads_api, client)
        puts "     Total: #{ga_campaigns[:total_counter]} (#{ga_campaigns[:pages_counter]}p)".colorize(:light_black)

        # Get GaCampaignInsights
        puts "   Getting Campaign Performance Report on #{DateTime.current.strftime("%F %T")}"
        GaCampaignInsight.get_from_ga(gads_api, client, { since: date_from.strftime("%Y%m%d"), until: date_to.strftime("%Y%m%d") })
        puts ""
      end
    end

    puts "   Ending on #{DateTime.current.strftime("%F %T")}.".colorize(:light_yellow)
    puts ""
  end
end
