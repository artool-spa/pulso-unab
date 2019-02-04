class Person < ApplicationRecord
  has_many :tickets
  has_many :log_mailer_sends
end
