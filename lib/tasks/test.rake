namespace :test do
  desc "TODO"
  task t: :environment do
    post_insights = %{
      {
        "data": [
          {
            "name": "post_impressions_unique",
            "period": "lifetime",
            "values": [
              {
                "value": 186673
              }
            ],
            "title": "Lifetime Post Total Reach",
            "description": "Lifetime: The number of people who had your Page's post enter their screen. Posts include statuses, photos, links, videos and more. (Unique Users)",
            "id": "572161723127136_625711077772200/insights/post_impressions_unique/lifetime"
          },
          {
            "name": "post_impressions_organic",
            "period": "lifetime",
            "values": [
              {
                "value": 10310
              }
            ],
            "title": "Lifetime Post Organic Impressions",
            "description": "Lifetime: The number of times your Page's posts entered a person's screen through unpaid distribution. (Total Count)",
            "id": "572161723127136_625711077772200/insights/post_impressions_organic/lifetime"
          },
          {
            "name": "post_impressions_organic_unique",
            "period": "lifetime",
            "values": [
              {
                "value": 7952
              }
            ],
            "title": "Lifetime Post organic reach",
            "description": "Lifetime: The number of people who had your Page's post enter their screen through unpaid distribution. (Unique Users)",
            "id": "572161723127136_625711077772200/insights/post_impressions_organic_unique/lifetime"
          },
          {
            "name": "post_impressions_paid",
            "period": "lifetime",
            "values": [
              {
                "value": 206935
              }
            ],
            "title": "Lifetime Post Paid Impressions",
            "description": "Lifetime: The number of times your Page's post entered a person's screen through paid distribution such as an ad. (Total Count)",
            "id": "572161723127136_625711077772200/insights/post_impressions_paid/lifetime"
          },
          {
            "name": "post_impressions_paid_unique",
            "period": "lifetime",
            "values": [
              {
                "value": 178649
              }
            ],
            "title": "Lifetime Post Paid Reach",
            "description": "Lifetime: The number of people who had your Page's post enter their screen through paid distribution such as an ad. (Unique Users)",
            "id": "572161723127136_625711077772200/insights/post_impressions_paid_unique/lifetime"
          },
          {
            "name": "post_negative_feedback",
            "period": "lifetime",
            "values": [
              {
                "value": 8
              }
            ],
            "title": "Lifetime Negative Feedback from Users",
            "description": "Lifetime: The number of times people have given negative feedback to your post. (Total Count)",
            "id": "572161723127136_625711077772200/insights/post_negative_feedback/lifetime"
          },
          {
            "name": "post_negative_feedback_unique",
            "period": "lifetime",
            "values": [
              {
                "value": 8
              }
            ],
            "title": "Lifetime Negative feedback",
            "description": "Lifetime: The number of people who have given negative feedback to your post. (Unique Users)",
            "id": "572161723127136_625711077772200/insights/post_negative_feedback_unique/lifetime"
          },
          {
            "name": "post_engaged_fan",
            "period": "lifetime",
            "values": [
              {
                "value": 30
              }
            ],
            "title": "Lifetime People who have liked your Page and engaged with your post",
            "description": "Lifetime: The number of people who have liked your Page and clicked anywhere in your posts. (Unique Users)",
            "id": "572161723127136_625711077772200/insights/post_engaged_fan/lifetime"
          },
          {
            "name": "post_reactions_by_type_total",
            "period": "lifetime",
            "values": [
              {
                "value": {
                  "like": 2014,
                  "love": 67,
                  "wow": 42,
                  "haha": 190,
                  "sorry": 8,
                  "anger": 143
                }
              }
            ],
            "title": "Lifetime Total post Reactions by Type.",
            "description": "Lifetime: Total post reactions by type.",
            "id": "572161723127136_625711077772200/insights/post_reactions_by_type_total/lifetime"
          },
          {
            "name": "post_impressions",
            "period": "lifetime",
            "values": [
              {
                "value": 217245
              }
            ],
            "title": "Lifetime Post Total Impressions",
            "description": "Lifetime: The number of times your Page's post entered a person's screen. Posts include statuses, photos, links, videos and more. (Total Count)",
            "id": "572161723127136_625711077772200/insights/post_impressions/lifetime"
          }
        ],
        "paging": "--sanitized--",
        "__debug__": {}
      }
    }.gsub(/\s+/, " ").strip

    post_insights = JSON.parse(post_insights)
    #puts ">> post_insights: >>>>>>>>>>>>>>>>>>>>>>"
    #ap post_insights

    post_insights["data"].each do |p_i|
      puts ">> Insights Name: #{p_i["name"]}"
      #puts Hash[pi.map { |v| [v["name"], v["values"]["value"]] }] rescue {}
      puts Hash[p_i["name"], p_i["values"][0]["value"]]
      #post_insights = Hash[p_i.map { |v| [v["name"], v["values"][0]["value"]] }]
    end
  end

end
