require 'rails_helper'
require 'factory_bot'

RSpec.describe User, type: :model do
    subject { create :user }
  
    it 'sends an email' do

      expect { subject.send_instructions }
      #Verify that the email counts in the delivery array, increased by one
        .to change { ActionMailer::Base.deliveries.count }.by(1)
        byebug
    end
  end