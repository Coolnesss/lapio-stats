require 'rails_helper'
require 'rack/test'

describe "Submission" do
  describe "When not signed in" do

    before :each do
      week = FactoryGirl.create :week
      FactoryGirl.create(:submission, week: week)
      FactoryGirl.create(:submission, week: week)
      FactoryGirl.create(:submission, week: week)
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
      expect(page).to have_content(User.first.student_id)
      fill_in("Find submission with student number", with: User.second.student_id)
      click_button("Search")

      expect(page).not_to have_content(User.first.student_id)
    end

    it "can click on student id to see its submissions" do
      visit submissions_path
      expect(page).to have_content(User.first.student_id)

      click_link(User.first.student_id)
      expect(page).not_to have_content(User.second.student_id)
      expect(page).to have_content("First week (1)")
    end
  end

  describe "When signed in" do

    before :each do
      FactoryGirl.create :user
      sign_in(student_id: User.first.student_id , password:"paras")
    end

    it "can access submission create page" do
      visit new_submission_path
      expect(page).to have_content("New Submission")
    end

    it "can create a submission" do
      FactoryGirl.create :week
      visit new_submission_path

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

      fill_in("Points", with: 12)
      click_button("Submit")

      expect(Submission.count).to eq(1)
      expect(Submission.first.points).to eq(12)
    end


    it "can access edit page" do
      FactoryGirl.create :submission, user: User.first
      visit edit_submission_path(Submission.first)
      expect(page).to have_content "Editing Submission"
    end

    it "can access own submission edit page from index page" do
      FactoryGirl.create :submission, user: User.first

      visit submissions_path
      click_link("Edit")

      expect(page).to have_content("Editing Submission")
    end

    it "can edit own submission" do
      FactoryGirl.create :submission, user: User.first

      visit edit_submission_path(Submission.first)
      expect(Submission.first.points).not_to eq 1

      fill_in("Points", with: 1)
      click_button("Submit")

      expect(Submission.first.points).to eq 1
    end

    it "can't edit others submissions" do
      user = FactoryGirl.create :user
      submission = FactoryGirl.create :submission, user: user

      visit edit_submission_path(submission)
      expect(page).to have_content("This isn't yours to modify!")

    end

    it "can delete own submission" do
      FactoryGirl.create :submission, user: User.first

      visit submissions_path

      click_link("Destroy")
      expect(Submission.count).to eq(0)
    end

    it "can't edit or destroy others submission" do
      FactoryGirl.create :submission, user: User.second
      visit submissions_path

      expect(page).not_to have_content("Destroy")
      expect(page).not_to have_content("Edit")
    end
    it "saves a user id when a user creates a submission" do
      FactoryGirl.create :week
      visit new_submission_path


      fill_in("Points", with: 12)
      click_button("Submit")

      expect(Submission.first.user).to eq(User.first)
    end

    it "redirects to edit page if trying to create duplicate" do
      FactoryGirl.create :submission, user: User.first
      visit new_submission_path

      fill_in("Points", with: 12)
      click_button("Submit")

      expect(page).to have_content("Editing Submission")
      expect(page).to have_content("You already have a submission for this week. Edit it below.")
    end

    it "doesnt redirect if creating new submission for a different week" do
      FactoryGirl.create(:week, name:"Best week")
      FactoryGirl.create(:submission)

      visit new_submission_path
      fill_in("Points", with: 12)
      click_button("Submit")

      expect(page).to have_content("Submission was successfully created")
    end
  end
end
