require 'spec_helper'

describe User do
  describe "#decrement_credits" do
    it "decrements the credits by the volume" do
      user = FactoryGirl.create(:user, credits: 5)
      user.decrement_credits(3)

      expect(user.credits).to eq(2)
    end

    it "does not set the value if credits are nil" do
      # If there are no credits set, the user has unlimited pours
      user = FactoryGirl.create(:user, credits: nil)
      user.decrement_credits(3)

      expect(user.credits).to eq(nil)
    end

    it "does not decrement below zero" do
      user = FactoryGirl.create(:user, credits: 5)
      user.decrement_credits(6)

      expect(user.credits).to eq(0)
    end
  end

  describe "#pours_remaining?" do
    it "is true if credits are nil" do
      # If there are no credits set, the user has unlimited pours
      user = FactoryGirl.create(:user, credits: nil)
      expect(user.pours_remaining?).to eq(true)
    end

    it "is true if credits are non zero" do
      user = FactoryGirl.create(:user, credits: 5)
      expect(user.pours_remaining?).to eq(true)
    end

    it "is false if credits are at zero" do
      user = FactoryGirl.create(:user, credits: 0)
      expect(user.pours_remaining?).to eq(false)
    end
  end
end
