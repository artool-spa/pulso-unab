require 'rails_helper'

RSpec.describe 'Status requests' do
  describe 'GET /status' do
    it 'returns status message' do
      get('/status')
      res=response.status
      #json = JSON.parse(response.status)
      expect(res).to eql(200)
    end 
  end
  describe 'Verify fields and content' do
    it 'Check if exist field' do
      get('/status')
      json = JSON.parse(response.body)
      json['data'].each do |t|
        expect(t.keys).to contain_exactly('answer', 'rut', 'id_ticket','answer_details')
        expect(t['answer_details'].keys).to contain_exactly('option1','option2','option3')
      end
    end
    it 'Check if exist content' do
      get('/status')
      json = JSON.parse(response.body)
      json['data'].each do |t|
        expect(!t['id_ticket'].blank?)
        expect(!t['rut'].blank?)
      end
    end
  end

end