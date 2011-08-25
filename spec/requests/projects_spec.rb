require 'spec_helper'

describe "Projects" do

  before :all do
    @project = Factory(:project)
  end

  context "admin" do

    before :each do
      login( Factory(:admin) )
    end

    it "should be able to see a list of projects" do
      visit projects_path
      page.should have_content("My test project")
    end

    it "should be able to edit a project" do
      visit projects_path
      click_link "My test project"
      fill_in "Name", :with => "My new test project"
      click_button "Save"
      page.should have_content("My new test project was saved!")
    end

    it "should be able to create a project" do
      visit new_project_path
      fill_in "Name", :with => "My hot new project"
      check "Is active"
      click_button "Save"
      page.should have_content("My hot new project was created!")
    end

    it "should be able to be destroyed" do
      visit projects_path
      click_link "Delete"
      page.should have_content("Successfully deleted")
    end
  end

  context "guest" do

    it "should not allow the user to manage projects" do
      visit projects_path
      page.should have_content("Access denied")

      visit new_project_path
      page.should have_content("Access denied")

      visit edit_project_path(@project)
      page.should have_content("Access denied")
    end

  end

end
