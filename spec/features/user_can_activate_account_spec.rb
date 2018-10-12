require 'rails_helper'

feature 'guest user can activate their account' do
  scenario 'when clicking email link' do
    allow_any_instance_of(User).to receive(:generate_token).and_return("abc123")

    visit '/register'

    fill_in :user_email, with: 'jessica@example.com'
    fill_in :user_name, with: 'jessica'
    fill_in :user_password, with: 'test'
    fill_in :user_password_confirmation, with: 'test'
    click_on 'Submit'
    user = User.last
    visit "users/abc123/confirmation"

    expect(page).to have_content("Thank you! Your account is now activated.")
    expect(user.status).to eq('active')

    visit '/dashboard'
    expect(current_path).to eq('/dashboard')
    expect(page).to have_content("Status: Active")
  end
end
