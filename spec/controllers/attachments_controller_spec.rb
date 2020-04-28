require 'rails_helper'

RSpec.describe AttachmentsController, type: :controller do
  describe 'DELETE #destroy' do
    sign_in_user
    let(:question) { create(:question, user: @user) }
    let(:answer) { create(:answer, question: question, user: @user, attachments: create_list(:attachment, 2)) }

    it 'Removes file from db' do
      delete :destroy, params: { id: answer }, format: :js
    end
  end

end
