require "rails_helper"

feature "Admin manages the users" do
  scenario "Admin create new user" do
    admin = create :admin
    login_feature admin

    visit root_path

    expect{
      click_link "Users"
      click_link "Add User"
      fill_in "Email", with: "newestuser@gmail.com"
      fill_in "Password", with: "Secret123"
      fill_in "Confirmation", with: "Secret123"
      fill_in "Fullname", with: "Jackie Chang"
      click_button "Create User"
    }.to change(User, :count).by 1

    expect(current_path).to eq admin_user_path id: 2
    within "h3" do
      expect(page).to have_content "Jackie Chang"
    end
    expect(page).to have_content "newestuser@gmail.com"
  end
end