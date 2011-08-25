require 'spec_helper'

describe "Session" do

  context "User" do

    it "should be able to login" do
      user = Factory(:user)
      visit new_sessions_path
      within("#login") do
        fill_in "Email", :with => user.email
        fill_in "Password", :with => user.password
      end
      click_button "Login"
      page.should have_content("Logged in!")
    end

    it "should not be able to login" do
      visit new_sessions_path
      within("#login") do
        fill_in "Email", :with => "wrong@example.com"
        fill_in "Password", :with => "wrong"
      end
      click_button "Login"
      page.should have_content("Invalid email or password")
    end

    it "should be able to log out" do
      login
      visit logout_path
      page.should have_content("Logged out!")
    end

  end

end
