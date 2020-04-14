require 'rails_helper'

feature 'User can delete own questions and answers' do
  given(:user) { create(:user) }
  given(:user_2) { create(:user) }
  given(:question) { create(:question, user_id: user.id) }

  scenario 'Author delete own question' do
    sign_in(user)
    visit question_path(question)
    click_on 'Delete question'

    expect(current_path).to eq questions_path
  end

  scenario 'Another user tries to delete question' do
    sign_in(user_2)
    visit question_path(question)
    click_on 'Delete question'

    expect(current_path).to eq question_path(question)
    expect(page).to have_content 'You dont have such permission!'
  end
end