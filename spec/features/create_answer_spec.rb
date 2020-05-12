require 'rails_helper'

feature 'User create answer to question' do
  given(:user) { create(:user) }
  given(:user_2) { create(:user) }
  given(:question) { create(:question) }

  scenario 'Authenticated user creates answer to question', js: true do
    sign_in(user)

    visit question_path(question)

    question_link = current_path

    fill_in 'Your answer', with: 'Test answer'
    click_on 'Add answer'

    expect(current_path).to eq question_link

    within '.answers' do
      expect(page).to have_content 'Test answer'
    end
  end

  scenario 'Non-authenticated user tries to create answer' do
    visit question_path(question)

    expect(page).to_not have_content 'Add answer'
  end
end