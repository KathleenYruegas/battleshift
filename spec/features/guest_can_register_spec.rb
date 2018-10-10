require "rails_helper"

# As a guest user
feature 'As a guest user' do
  describe "when I visit /" do
    scenario 'I can register' do
# When I visit "/"
      visit '/'
# And I click "Register"
      click_on "Register"
# Then I should be on "/register"
      expect(current_path).to eq('/register')
# And when I fill in an email address (required)
# And I fill in name (required)
# And I fill in password and password confirmation (required)
      fill_in :user_email, with: "myemail@email.com"
      fill_in :user_name, with: "Sample Person"
      fill_in :user_password, with: "test"
      fill_in :user_password_confirmation, with: "test"
# And I click submit
      click_on "Submit"
# Then I should be redirected to "/dashboard"
# And I should see a message that says "Logged in as <SOME_NAME>"
# And I should see "This account has not yet been activated. Please check your email."
      expect(current_path).to eq('/dashboard')
      expect(page).to have_content("Logged in as Sample Person.")
      expect(page).to have_content("This account has not yet been activated. Please check your email.")
    end
  end
end
