require 'rails_helper'

RSpec.describe 'Profile API' do
  describe 'GET /me' do
    context 'unauthorized' do
      headers = {
        "CONTENT_TYPE" => "application/json"
      }

      it 'returns 401 status if there is no access_token' do
        get '/api/v0/profiles/me', headers: headers
        expect(response.status).to eq 401
      end

      it 'returns 401 if access_token is invalid' do
        get '/api/v0/profiles/me', headers: headers, params: { access_token: '1234' }
        expect(response.status).to eq 401
      end
    end

    context 'authorized' do
      let!(:application) { create(:application) }
      let!(:me) { create(:user, admin: true) }
      let!(:access_token) { create(:access_token, application: application, resource_owner_id: me.id) }

      before do
        headers = {
          "CONTENT_TYPE" => "application/json",
          "Authorization" => "Bearer #{access_token.token}"
        }

        get '/api/v0/profiles/me', headers: headers
      end

      it 'returns 200 status' do
        expect(response.status).to eq 200
      end

      %w(id email first_name last_name).each do |attr|
        it "contains #{attr}" do
          expect(response.body).to be_json_eql(me.send(attr.to_sym).to_json).at_path(attr)
        end
      end

      %w(password encrypted_password).each do |attr|
        it "does not contain #{attr}" do
          expect(response.body).to_not have_json_path(attr)
        end
      end
    end
  end
end
