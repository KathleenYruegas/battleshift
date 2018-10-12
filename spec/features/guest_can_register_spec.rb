require "rails_helper"

feature 'As a guest user' do
  describe "when I visit /" do
    scenario 'I can register' do
      visit '/'

      click_on "Register"

      expect(current_path).to eq('/register')

      fill_in :user_email, with: "myemail@email.com"
      fill_in :user_name, with: "Sample Person"
      fill_in :user_password, with: "test"
      fill_in :user_password_confirmation, with: "test"

      click_on "Submit"

      expect(current_path).to eq('/dashboard')
      expect(page).to have_content("Logged in as Sample Person.")
      expect(page).to have_content("This account has not yet been activated. Please check your email.")
    end
  end
end
