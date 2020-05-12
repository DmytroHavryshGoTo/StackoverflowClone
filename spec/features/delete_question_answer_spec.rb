require 'rails_helper'

feature 'User can delete own questions and answers' do
  given(:user) { create(:user) }
  given(:user_2) { create(:user) }
  given(:question) { create(:question, user_id: user.id) }
  given(:answer) { create(:answer, user_id: user.id, question_id: question.id) }

  context 'as author' do
    before do
      sign_in(user)
      answer
      visit question_path(question)
    end

    scenario 'deletes question' do
      within '.single-question' do
        click_on 'Delete'
      end

      expect(current_path).to eq questions_path
    end

    scenario 'deletes answer', js: true do
      within '.answers' do
        click_on 'delete'
        page.driver.browser.switch_to.alert.accept
        expect(page).to_not have_content answer.body
      end
    end
  end

  context 'as another user' do
    before do
      sign_in(user_2)
      answer
      visit question_path(question)
    end

    scenario 'tries to delete question' do
      expect(page).to_not have_content 'Delete'
    end

    scenario 'deletes answer' do
      within '.answers' do
        expect(page).to_not have_content 'delete'
      end
    end
  end
end