require 'rails_helper'

feature 'User can mark answer as best for question' do
  given(:author) { create(:user) }
  given(:user) { create(:user) }
  given(:question) { create(:question, user: author) }
  given(:answer) { create(:answer, question: question) }

  scenario 'Author marks answer as best', js: true do
    sign_in(author)
    answer
    visit question_path(question)

    within '.answers' do
      click_on 'mark as best'
      expect(page).to_not have_content 'mark as best'
      expect(page).to have_css '.best'
    end
  end
  scenario 'Non-author does not see button' do
    sign_in(user)
    answer
    visit question_path(question)

    within '.answers' do
      expect(page).to_not have_content 'mark as best'
    end
  end
end
