require 'rails_helper'

RSpec.describe QuestionsController, type: :controller do
  let(:question) { create(:question) }

  describe 'GET #index' do
    let(:questions) { create_list(:question, 2) }

    before do
      get :index
    end

    it 'returns all questions' do
      expect(assigns(:questions)).to match_array(questions)
    end

    it 'should render index view' do
      expect(response).to render_template :index
    end
  end

  describe 'GET #show' do
    sign_in_user
    before do
      get :show, params: { id: question }
    end

    it 'assigns question to @question' do
      expect(assigns(:question)).to eq question
    end

    it 'builds new attachment for answer' do
      expect(assigns(:answer).attachments.first).to be_a_new(Attachment)
    end

    it 'assigns answer to @answer' do
      expect(assigns(:answer)).to be_a_new(Answer)
    end

    it 'renders show view' do
      expect(response).to render_template :show
    end
  end

  describe 'Get #new' do
    sign_in_user
    before { get :new}

    it 'assigns new question to new @question' do
      expect(assigns(:question)).to be_a_new(Question)
    end

    it 'builds new attachment for question' do
      expect(assigns(:question).attachments.first).to be_a_new(Attachment)
    end

    it 'renders new view' do
      expect(response).to render_template :new
    end
  end

  describe 'POST #create' do
    sign_in_user
    context 'creating question with valid data' do
      it 'saves question in database' do
        expect { post :create, params: { question: attributes_for(:question) } }.to change(Question, :count).by(1)
      end

      it 'redirects to show view' do
        post :create, params: { question: attributes_for(:question) }
        expect(response).to redirect_to assigns(:question)
      end
    end

    context 'creating question with invalid data' do
      it 'does not save question in database' do
        expect { post :create, params: { question: { title: nil, body: nil } } }.to_not change(Question, :count)
      end

      it 'renders new view' do
        post :create, params: { question: { title: nil, body: nil } }
        expect(response).to render_template :new
      end
    end
  end

  describe 'PATCH #update' do
    sign_in_user
    let(:own_question) { create(:question, user: @user) }

    context 'valid data' do
      it 'assigns the requested question to @question' do
        patch :update, params: { id: own_question, question: attributes_for(:question) }, format: :js
        expect(assigns(:question)).to eq own_question
      end

      it 'updates question attributes' do
        patch :update, params: { id: own_question, question: { title: 'Test', body: 'Body'} }, format: :js
        own_question.reload
        expect(own_question.title).to eq 'Test'
        expect(own_question.body).to eq 'Body'
      end

      it 'renders show view' do
        patch :update, params: { id: own_question, question: attributes_for(:question) }, format: :js
        expect(response).to redirect_to own_question
      end
    end

    context 'invalid data' do
      before do
        @prev_title = own_question.title
        patch :update, params: { id: own_question, question: { title: nil, body: nil } }, format: :js
      end

      it 'updates question attributes' do
        own_question.reload
        expect(own_question.title).to eq @prev_title
        expect(own_question.body).to eq 'MyString'
      end

      it 'renders update view' do
        expect(response).to render_template :update
      end
    end
  end

  describe 'DELETE #destroy' do
    sign_in_user

    let(:own_question) { create(:question, user: @user) }

    it 'removes question from database' do
      own_question
      expect { delete :destroy, params: { id: own_question } }.to change(Question, :count).by(-1)
    end

    it 'redirects to all questions' do
      delete :destroy, params: { id: own_question }
      expect(response).to redirect_to questions_path
    end
  end
end
