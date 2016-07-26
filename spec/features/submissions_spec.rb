require 'rails_helper'
require 'rack/test'

describe "Submission" do
  describe "When not signed in" do

    before :each do
      week = FactoryGirl.create :week
      FactoryGirl.create(:submission, week: week)
      FactoryGirl.create(:submission, student_id: "014524721", week: week)
      FactoryGirl.create(:submission, student_id: "123123123", week: week)
    end

    it "cannot create submission" do
      visit new_submission_path
      expect(page).to have_content "you should be signed in"
    end

    it "cannot delete a submission" do
      visit submissions_path
      expect(page).not_to have_content("Destroy")
    end

    it "cannot see submission create form on weeks page" do
      visit weeks_path
      expect(page).not_to have_content("Create Submission")
    end

    it "can see submissions on list page" do
      visit submissions_path

      expect(page).to have_content(Submission.first.student_id)
      expect(page).to have_content(Submission.second.student_id)
      expect(page).to have_content(Submission.third.student_id)
    end

    it "can search for submissions on list page" do
      visit submissions_path
      expect(page).to have_content("123123123")

      fill_in("Find submission with student number", with: "014475359")
      click_button("Search")

      expect(page).to have_content("First week (1)")
      expect(page).not_to have_content("123123123")
    end

    it "can click on student id to see its submissions" do
      visit submissions_path
      expect(page).to have_content("123123123")

      click_link("014475359")
      expect(page).not_to have_content("123123123")
      expect(page).to have_content("First week (1)")
    end
  end

  describe "When signed in" do

    before :each do
      FactoryGirl.create :user
      sign_in(name: User.first.name , password:"paras")
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

    it "Cannot create a submission with an invalid student ID" do
      FactoryGirl.create :week
      visit weeks_path
      click_link("Create Submission")
      fill_in("Student", with: "014401444")
      fill_in("Points", with: 12)
      click_button("Submit")

      expect(page).to have_content("Student ID is not valid")
    end

    it "can access edit page" do
      FactoryGirl.create :submission
      visit edit_submission_path(Submission.first)
      expect(page).to have_content "Editing Submission"
    end

    it "can access edit page from index page" do
      FactoryGirl.create :submission

      visit submissions_path
      click_link("Edit")

      expect(page).to have_content("Editing Submission")
    end

    it "can edit submission" do
      FactoryGirl.create :submission

      visit edit_submission_path(Submission.first)
      expect(Submission.first.points).not_to eq(0)

      fill_in("Points", with: 0)
      click_button("Submit")

      expect(Submission.first.points).to eq(0)
    end

    it "can delete submission" do
      FactoryGirl.create :submission

      visit submissions_path

      click_link("Destroy")
      expect(Submission.count).to eq(0)
    end

    it "saves a user id when a user creates a submission" do
      FactoryGirl.create :week
      visit new_submission_path

      fill_in("Student", with: "014475359")
      fill_in("Points", with: 12)
      click_button("Submit")

      expect(Submission.first.user).to eq(User.first)
    end

    it "redirects to edit page if trying to create duplicate" do
      FactoryGirl.create(:submission)
      visit new_submission_path

      fill_in("Student", with: "014475359")
      fill_in("Points", with: 12)
      click_button("Submit")

      expect(page).to have_content("Editing Submission")
      expect(page).to have_content("Submission for student with same exercise set already exists. Edit it below.")
    end

    it "doesnt redirect if creating new submission for a different week" do
      FactoryGirl.create(:week, name:"Best week")
      FactoryGirl.create(:submission)

      visit new_submission_path
      fill_in("Student", with: "014475359")
      fill_in("Points", with: 12)
      click_button("Submit")

      expect(page).to have_content("Submission was successfully created")
    end
  end
end
