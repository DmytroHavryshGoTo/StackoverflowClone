# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Questions API' do
  let!(:user) { create(:user) }
  let!(:access_token) { create(:access_token, resource_owner_id: user.id) }

  describe 'GET /' do
    unauthorized_headers = {
      'CONTENT_TYPE' => 'application/json'
    }

    let!(:questions) { create_list(:question, 2) }

    before do
      get '/api/v0/questions/', headers: unauthorized_headers
    end

    it 'returns 200 status' do
      expect(response.status).to eq 200
    end

    it 'returns list of all questions' do
      expect(response.body).to have_json_size 2
    end
  end

  describe 'GET /:id' do
    let!(:question) { create(:question) }
    let!(:answer) { create(:answer, question: question) }
    let!(:attachment) { create(:attachment, attachable: answer) }
    let!(:answer2) { create(:answer, question: question) }

    before do
      unauthorized_headers = {
        'CONTENT_TYPE' => 'application/json'
      }

      get "/api/v0/questions/#{question.id}", headers: unauthorized_headers
    end

    it 'returns 200 status' do
      expect(response.status).to eq 200
    end

    %w[id title body created_at updated_at attachments].each do |attr|
      it "contains #{attr}" do
        expect(response.body).to be_json_eql(question.send(attr.to_sym).to_json).at_path(attr)
      end
    end

    it 'contains its answers' do
      expect(response.body).to have_json_size(2).at_path('answers')
    end

    it 'contains author' do
      expect(response.body).to have_json_path('user')
    end

    %w[id body].each do |attr|
      it "contains answers/#{attr}" do
        expect(response.body).to be_json_eql(answer.send(attr.to_sym).to_json).at_path("answers/0/#{attr}")
      end
    end
  end

  describe 'POST /' do
    context 'unauthorized' do
      it 'return 401 if there is not access token' do
        unauthorized_headers = {
          'CONTENT_TYPE' => 'application/json'
        }

        post '/api/v0/questions', headers: unauthorized_headers
        expect(response.status).to eq 401
      end

      it 'return 401 if access token is invalid' do
        invalid_token_headers = {
          'CONTENT_TYPE' => 'application/json',
          'Authorization' => 'Bearer 12341412214124'
        }

        post '/api/v0/questions', headers: invalid_token_headers
        expect(response.status).to eq 401
      end
    end

    context 'authorized' do
      context 'valid question params' do
        let(:question_params) { attributes_for(:question) }

        before do
          authorized_headers = {
            'Authorization' => "Bearer #{access_token.token}"
          }

          post '/api/v0/questions', headers: authorized_headers, params: { question: question_params }
        end

        it 'returns 201 status' do
          expect(response.status).to eq 201
        end

        %w[title body].each do |attr|
          it "response contains #{attr}" do
            expect(response.body).to be_json_eql(question_params[attr.to_sym].to_json).at_path(attr.to_s)
          end
        end
      end

      context 'invalid question params' do
        let(:invalid_question_params) { { title: '', body: '' } }
        let(:error) { ["Title can't be blank", "Body can't be blank",] }

        before do
          authorized_headers = {
            'Authorization' => "Bearer #{access_token.token}"
          }

          post '/api/v0/questions', headers: authorized_headers, params: { question: invalid_question_params }
        end

        it 'return 400 status' do
          expect(response.status).to eq 400
        end

        it 'returns error msg' do
          expect(response.body).to be_json_eql(error.to_json)
        end
      end
    end
  end
end
