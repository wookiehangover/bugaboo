require 'spec_helper'

describe "Bugs" do

  before :all do
    @bug  = Factory(:bug)
  end

  context "user" do

    before :each do
      @user = Factory(:user)
      login( @user )
    end

    it "should be able to see a paginated list of bugs" do
      FactoryGirl.create_list(:bug, 25)
      visit bugs_path
      page.should have_content("The website is down")
      page.should have_content("2")
    end

    it "should be able to edit a bug" do
      visit bugs_path
      click_link "The website is down"
      fill_in "Summary", :with => "The internet is down"
      click_button "Save"
      page.should have_content("Bug saved")
      click_link "The internet is down"
      find_field('Summary').value.should == "The internet is down"


    end

    it "should be able to create a bug" do
      visit new_bug_path
      fill_in "Summary", :with => "It's very broken"
      fill_in "Steps to reproduce", :with => "Click the link"
      select('Meh', :from => 'Severity')
      select(@user.projects.first.name, :from => 'bug_project_id')
      select('Open', :from => 'Current state')
      click_button "Save"
      page.should have_content("Bug was created!")
    end

    it "should be able to be destroyed" do
      visit bugs_path
      click_link "Delete"
      page.should have_content("Successfully deleted")
    end
  end

  context "guest" do

    before :each do
      Factory(:project, :name => "Project One")
    end

    it "should not allow the user to manage bugs" do
      visit bugs_path
      page.should have_content("Access denied")

      visit new_bug_path
      page.should have_content("Access denied")

      visit edit_bug_path(@bug)
      page.should have_content("Access denied")
    end

  end

end

