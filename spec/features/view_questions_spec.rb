require 'rails_helper'

feature 'User can view all questions' do
  given(:questions) { create_list(:question, 2) }
  given(:answer) { create(:answer, question_id: questions[0].id) }

  scenario 'Non-authenticated user views all questions' do
    questions
    answer
    visit questions_path
    expect(page).to have_content questions[0].title
    expect(page).to have_content questions[1].title
  end

  scenario 'Non-authenticated user views single question' do
    questions
    answer
    visit questions_path
    click_on questions[0].title

    expect(current_path).to eq question_path(questions[0])
    expect(page).to have_content questions[0].body
  end
end
