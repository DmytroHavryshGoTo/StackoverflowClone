require 'rails_helper'

RSpec.describe 'Answers API' do
  let!(:user) { create(:user) }
  let!(:access_token) { create(:access_token, resource_owner_id: user.id) }
  let!(:question) { create(:question) }
  let!(:answers) { create_list(:answer, 2, question: question) }
  let(:answer) { answers.first }
  let(:answer_params) { attributes_for(:answer) }

  describe 'GET /questions/:question_id/answers' do
    before do
      get "/api/v0/questions/#{question.id}/answers"
    end

    it 'returns 200 status' do
      expect(response.status).to eq 200
    end

    it 'returns list of all answers for this question' do
      expect(response.body).to have_json_size 2
    end
  end

  describe 'GET /questions/:question_id/answers/:id' do
    before do
      get "/api/v0/questions/#{question.id}/answers/#{answer.id}"
    end

    it 'returns 200 status' do
      expect(response.status).to eq 200
    end

    %w[body attachments].each do |attr|
      it "contains #{attr}" do
        expect(response.body).to be_json_eql(question.send(attr.to_sym).to_json).at_path(attr)
      end
    end
  end

  describe 'POST /questions/:question_id/answers' do
    let(:authorized_headers) { { 'Authorization' => "Bearer #{access_token.token}" } }

    before do
      post "/api/v0/questions/#{question.id}/answers", headers: authorized_headers, params: { answer: answer_params }
    end

    it 'return 201 status' do
      expect(response.status).to eq 201
    end

    %w[body].each do |attr|
      it "answer body equals sent answer body #{attr}" do
        expect(response.body).to be_json_eql(answer_params[attr.to_sym].to_json).at_path(attr.to_s)
      end
    end

    %w[id created_at updated_at].each do |attr|
      it "response contains #{attr}" do
        expect(response.body).to have_json_path(attr)
      end
    end
  end
end
