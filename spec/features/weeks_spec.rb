require 'rails_helper'

describe "Week" do

  describe "As admin" do
    before :each do
      FactoryGirl.create :admin
      sign_in(student_id: User.first.student_id, password: "best")
    end

    it "can create a week" do
      visit new_week_path
      fill_in("week_max_points", with: 100)
      fill_in("Name", with:"Best week")
      click_button("Create Week")

      expect(Week.count).to eq(1)
      expect(page).to have_content("Best week")
    end
    
    it "can edit week" do
      FactoryGirl.create :week
      visit edit_week_path Week.first
      expect(Week.first.max_points).not_to eq 15

      fill_in :week_max_points, with: "15"
      click_button "Update Week"
      expect(Week.first.max_points).to eq 15
    end
  end

  describe "Without admin" do

    before :each do
      FactoryGirl.create :user
      sign_in(student_id: User.first.student_id, password: "paras")
    end

    it "cannot access new week page" do
      visit new_week_path
      expect(page).to have_content("you should be an admin to view this")
    end
  end

  describe "Without logging in" do
    it "cannot access new week page" do
      visit new_week_path
      expect(page).to have_content("you should be an admin to view this")
    end
  end
end
