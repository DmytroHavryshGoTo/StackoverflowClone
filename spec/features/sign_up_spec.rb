require 'rails_helper'

feature 'User sign up' do

  given(:user) { create(:user) }

  scenario 'Unregistered user tries to sing up' do
    visit root_path
    click_on 'Sign up'
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    fill_in 'Password confirmation', with: user.password_confirmation
    click_on 'Register'

    expect(current_path).to eq user_registration_path
  end
end