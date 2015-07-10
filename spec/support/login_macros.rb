module LoginMacros
  def login_feature user
    visit root_path
    find("#login").click
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Log in"
  end
end