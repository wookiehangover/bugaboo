require 'spec_helper'

describe "Users" do

  before :all do
    @user = Factory(:user)
  end

  context "admin" do

    before :each do
      login( Factory(:admin) )
      Factory(:project, :name => "Project Test One")
      Factory(:project, :name => "Project Test Two")
      Factory(:project, :name => "Project Test Three")
    end

    it "should be able to see a list of users" do
      visit users_path
      page.should have_content("Snoop Dogg")
    end

    it "should be able to edit a user" do
      visit users_path
      click_link "Snoop Dogg"
      fill_in "First name", :with => "Snoopy"
      fill_in "Last name", :with => "Dog"
      check "Project Test One"
      click_button "Save"
      page.should have_content("Snoopy Dog user was saved!")
      click_link "Snoopy Dog"
      page.should have_checked_field("Project Test One")
      uncheck "Project Test One"
      check "Project Test Two"
      click_button "Save"
      click_link "Snoopy Dog"

      page.should_not have_checked_field("Project Test One")
      page.should have_checked_field("Project Test Two")
    end

    it "should be able to create a user" do
      visit new_user_path
      fill_in "First name", :with => "Chuck"
      fill_in "Last name", :with => "Wagon"
      fill_in "Email", :with => "chuck@quickleft.com"
      fill_in "Password", :with => "secret"
      fill_in "Password confirmation", :with => "secret"
      click_button "Save"
      page.should have_content("Chuck Wagon user was created!")
    end

    it "should barf out errors" do
      visit new_user_path
      fill_in "First name", :with => "Chuck"
      fill_in "Last name", :with => "Wagon"
      fill_in "Password", :with => "secret"
      click_button "Save"
      page.should have_content("Form is invalid")
    end

    it "should be able to be destroyed" do
      visit users_path
      click_link "Delete"
      page.should have_content("Successfully deleted")
    end
  end

end

