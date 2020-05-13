# spec/models/token_spec.rb
require 'rails_helper'

RSpec.describe 'token' do
   it 'test' do
      expect(FactoryBot.build(:access_token)).to be_valid
   end
end
