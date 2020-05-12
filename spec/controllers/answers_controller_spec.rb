require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  sign_in_user
  let(:question) { create(:question, user: @user) }
  let(:answer) { create(:answer, question: question, user: @user) }

  describe 'POST #create' do

    context 'valid data' do
      it 'saves answer in db' do
        expect { post :create, params: { question_id: question, answer: attributes_for(:answer) }, format: :js }.to change(question.answers, :count).by(1)
      end

      it 'redirects to question, it belongs' do
        post :create, params: { question_id: question, answer: attributes_for(:answer) }, format: :js
        expect(response).to render_template :create
      end
    end
  end

  describe 'PATCH #update' do

    it 'assigns the requested answer to @answer' do
      patch :update, params: { id: answer, question_id: question, answer: attributes_for(:answer) }, format: :js
      expect(assigns(:answer)).to eq answer
    end

    it 'changes answer attributes' do
      patch :update, params: { id: answer, question_id: question, answer: { body: 'New body' } }, format: :js
      answer.reload
      expect(answer.body).to eq 'New body'
    end

    it 'render update template' do
      patch :update, params: { id: answer, question_id: question, answer: attributes_for(:answer) }, format: :js
      expect(response).to render_template :update
    end
  end

  describe 'DELETE #destroy' do
    before do
      question.answers
      answer
    end

    it 'removes answer from db' do
      expect { delete :destroy, params: { question_id: question, id: answer }, format: :js }.to change(question.answers, :count).by(-1)
    end

    it 'render delete js view' do
      delete :destroy, params: { question_id: question, id: answer }, format: :js

      expect(response).to render_template :destroy
    end
  end

  describe 'POST #mark_best' do
    let(:best_answer) { create(:answer, question: question, user: @user, best: true) }

    before do
      question
      answer
      best_answer
      post :mark_best, params: { question_id: question, id: answer }, format: :js
    end

    it 'makes question the best' do
      best_answer.reload
      answer.reload
      expect(best_answer.best).to eq false
      expect(answer.best).to eq true
    end

    it 'renders mark_best js view' do
      expect(response).to render_template :mark_best
    end
  end
end
