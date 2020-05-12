require 'rails_helper'

feature 'User can edit his answer' do
  given(:author) { create(:user) }
  given(:user) { create(:user) }
  given(:question) { create(:question) }
  given(:answer) { create(:answer, user: author, question: question) }

  scenario 'Author can edit own answer', js: true do
    sign_in(author)
    answer
    visit question_path(question)

    within '.answers' do
      click_on 'edit'
      fill_in 'Your answer', with: 'test'
      click_on 'Save'

      expect(page).to_not have_content answer.body
      expect(page).to have_content 'test'
      expect(page).to_not have_selector 'textarea'
    end
  end

  scenario 'Another user cannot edit answer' do
    sign_in(user)
    answer
    visit question_path(question)
    within '.answers' do
      expect(page).to_not have_content 'edit'
    end
  end
end