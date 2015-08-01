require 'rails_helper'
require 'rack/test'

describe "Submission" do
  describe "When not signed in" do
    it "cannot create submission without signin" do
      visit new_submission_path
      expect(page).to have_content "you should be signed in"
    end

    it "cannot see submission create form on weeks page" do
      visit weeks_path
      expect(page).not_to have_content("Create Submission")
    end    
  end

  describe "When signed in" do

    before :each do
      FactoryGirl.create :user
      sign_in(name:"joni", password:"paras")
    end

    it "can access submission create page" do
      visit new_submission_path
      expect(page).to have_content("New Submission")
    end

    it "can create a submission" do
      FactoryGirl.create :week
      visit new_submission_path
      fill_in("Student", with: "014475359")
      fill_in("Points", with: 12)
      click_button("Submit")

      expect(Submission.count).to eq(1)
      expect(Submission.first.points).to eq(12)
    end

    it "can create submission on weeks page" do
      FactoryGirl.create :week
      visit weeks_path
      expect(page).to have_content("Create Submission")
      click_link("Create Submission")
      fill_in("Student", with: "014475359")
      fill_in("Points", with: 12)
      click_button("Submit")

      expect(Submission.count).to eq(1)
      expect(Submission.first.points).to eq(12)
    end
  end




end
