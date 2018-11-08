require 'factory_bot'

FactoryBot.define do
  factory :user do
    email 'test@email.com'
    password '123456'
  end
end