FactoryBot.define do
  factory :log_mailer_send do
    send_mail { false }
    send_date { "2019-01-30 10:04:18" }
  end
end
