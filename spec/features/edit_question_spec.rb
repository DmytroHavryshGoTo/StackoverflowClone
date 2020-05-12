require 'rails_helper'

feature 'User can edit his question' do
  given(:author) { create(:user) }
  given(:guest) { create(:user) }
  given(:question) { create(:question, user_id: author.id) }

  scenario 'author can edit question', js: true do
    sign_in(author)
    visit question_path(question)
    within '.single-question' do
      click_on 'Edit'
      fill_in 'Title', with: 'New title'
      fill_in 'Body', with: 'New body'
      click_on 'Save'

      expect(page).to_not have_content question.title
      expect(page).to_not have_content question.body
      expect(page).to have_content 'New title'
      expect(page).to have_content 'New body'
      expect(page).to_not have_selector 'textarea'
    end
  end

  scenario 'not author cannot edit question' do
    sign_in(guest)
    visit question_path(question)
    within '.single-question' do
      expect(page).to_not have_content 'Edit'
    end
  end
end