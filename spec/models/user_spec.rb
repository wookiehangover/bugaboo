require 'spec_helper'

describe User do

  context "Guest user" do

    it "should be able to authenticate" do
      user = Factory(:user)
      User.authenticate(user.email, user.password).should_not == false
    end

    it "should not be able to authenticate" do
      user = Factory(:user)
      User.authenticate(user.email, 'wrong') == false
    end

  end

  context "Admin user" do

  end

  it "should be able to be soft deleted" do
    user = Factory(:user)
    user.should_not be_soft_deleted
    user.destroy
    user.should be_soft_deleted
  end

end
