class Client < ApplicationRecord
  include FbDb
  has_and_belongs_to_many :users
  #has_many :sheets
  has_many :fb_campaigns, dependent: :destroy
  has_many :fb_adsets, dependent: :destroy
  #has_many :fb_ads, dependent: :destroy
  has_many :labels, dependent: :destroy

  validates_uniqueness_of :fb_ad_account_id, allow_blank: true
  validates_uniqueness_of :ga_ad_account_id, allow_blank: true

  def self.as_select
    order(name: :asc).pluck("upper(name) || ' (CP: ' || fb_ad_account_id || ')', id")
  end

  def self.get_fb_campaigns_posts_with_comments(options = {})
    query_params = [options[:client_ids], options[:ds], options[:de]]

    sql = %{
      SELECT
        c.name as client_name, c.fb_ad_account_id as client_fb_ad_account_id, p.id as pub_id, p.pub_type, p.created_time as pub_created_time, fbci.fb_campaign_id as pub_fb_campaign_id, p.message as pub_message, p.n_shares, p.fb_user as pub_fb_user, p.fb_user_id as pub_fb_user_id,
        p.n_comments, p.reactions as pub_reactions,
        fbpc.id as com_id, fbpc.created_time as com_created_time, fbpc.message as com_message, fbpc.fb_user as com_fb_user, fbpc.fb_user_id as com_fb_user_id, fbpc.reactions as com_reactions,
        fbc.start_time as ad_c_start_time, fbc.stop_time as ad_c_stop_time,
        fbci.spend, fbci.impressions, fbci.reach, fbci.frequency, fbci.actions, fbci.video_watched
      FROM fb_posts p
      LEFT JOIN fb_comments fbpc ON(fbpc.fb_post_id = p.id)
      LEFT JOIN fb_structure_fb_posts asp ON(asp.fb_post_id = p.id)
      LEFT JOIN clients c ON(c.id = asp.client_id)
      LEFT JOIN fb_campaigns fbc ON(fbc.id = asp.fb_campaign_id)
      LEFT JOIN fb_campaign_insights fbci ON(fbci.fb_campaign_id = asp.fb_campaign_id)
      WHERE
        asp.client_id IN(?) AND (fbc.start_time::date >= ? AND fbc.stop_time::date <= ?)
    }

    sql.concat(%{ORDER BY p.created_time DESC, c.name ASC})

    FbDb.raw_query(sql, query_params)
  end
end
