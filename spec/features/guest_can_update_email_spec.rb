require 'rails_helper'

feature 'guest visit user index page' do
  scenario 'can click on edit and go to edit page to update the email address' do
    file = File.open("./fixtures/single_user_data.json")
    stub_request(:get, "http://localhost:3000/api/v1/users/1")
      .to_return(body: file, status: 200)

    file2 = File.open("./fixtures/all_user_data.json")
    stub_request(:get, "http://localhost:3000/api/v1/users")
      .to_return(body: file2, status: 200)

    file3 = File.open("./fixtures/update_user_email.json")
    stub_request(:patch, "http://localhost:3000/api/v1/users/")
      .to_return(body: file3, status: 200)

    visit '/users'

    user = User.create(id: 1, name: 'Josiah Bartlet', email: 'jbarlet@example.com')

    within("#user-#{user.id}") do
      click_on 'Edit'
    end

    expect(current_path).to eq('/users/1/edit')

    fill_in :email, with: "josiah@example.com"
    click_on 'Save'

    expect(current_path).to eq('/users')

    expect(page).to have_content('Successfully updated Josiah Bartlet.')
  end
end
