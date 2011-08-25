require 'spec_helper'
require 'cancan/matchers'

describe Ability do

  context "Guest" do

    it "should not be able to manage any user" do
      ability = Ability.new(nil)
      ability.should_not be_able_to(:manage, User.new)
    end

  end

  context "Admin" do

    it "should be able to manage all" do
      admin = Factory(:admin)
      ability = Ability.new(admin)
      ability.should be_able_to(:manage, :all)
    end

  end

  context "Authenticated user" do

    it "should be able to read, update, edit themseleves" do
      user = Factory(:user)
      ability = Ability.new(user)
      ability.should be_able_to(:manage, user)
    end

    it "should not be able to manage someone else" do
      user = Factory(:user)
      admin = Factory(:admin)
      ability = Ability.new(user)
      ability.should_not be_able_to(:manage, admin)
    end

  end

end
