require 'rails_helper'

feature 'guest user can activate their account' do
  xscenario 'when clicking email link' do
    user = create(:user)

    visit edit_confirmation_path(user.activation_token)

    expect(page).to have_content("Thank you! Your account is now activated.")

    # expect(user.status).to eq('active')

    visit '/dashboard'
    expect(current_path).to eq('/dashboard')
    expect(page).to have_content("Status: Active")
  end
end
