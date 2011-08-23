require 'spec_helper'
require 'cancan/matchers'

describe Ability do

  context "Guest" do

  end

  context "Admin" do

    it "should be able to manage all" do
      admin = Factory(:admin)
      ability = Ability.new(admin)
      ability.should be_able_to(:manage, :all)
    end

  end

end
