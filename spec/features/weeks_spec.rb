require 'rails_helper'

describe "Week" do

  describe "As admin" do
    before :each do
      FactoryGirl.create :user
      sign_in(name:"joni", password:"paras")
    end

    it "can create a week" do
      visit new_week_path
      fill_in("week_max_points", with:100)
      fill_in("Name", with:"Best week")
      click_button("Create Week")

      expect(Week.count).to eq(1)
      expect(page).to have_content("Best week")
    end
  end

  describe "Without admin" do
    it "cannot access new week page" do
      visit new_week_path
      expect(page).to have_content("you should be signed in")
    end
  end
end
