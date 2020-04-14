require 'rails_helper'

feature 'User create answer to question' do
  given(:user) { create(:user) }
  given(:user_2) { create(:user) }
  given(:question) { create(:question) }

  scenario 'Authenticated user creates answer to question' do
    sign_in(user)

    visit question_path(question)

    question_link = current_path

    fill_in 'Body', with: 'Test answer'
    click_on 'Add answer'

    expect(current_path).to eq question_link
    expect(page).to have_content 'Test answer'
  end

  scenario 'Non-authenticated user tries to create answer' do
    visit question_path(question)
    fill_in 'Body', with: 'Test answer'
    click_on 'Add answer'

    expect(current_path).to eq new_user_session_path
  end
end