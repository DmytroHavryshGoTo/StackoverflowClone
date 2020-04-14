require 'rails_helper'

feature 'Log out from account' do
  given(:user) { create(:user) }

  scenario 'Registered user try to log out' do
    sign_in(user)
    click_on 'Sign out'

    expect(page).to have_content 'Signed out successfully.'
    expect(current_path).to eq root_path
  end
end