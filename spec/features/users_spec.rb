require 'rails_helper'

describe "User" do

  describe "When not logged in" do

    def sign_up(student_id, password, password_confirmation)
      visit signup_path

      fill_in "user[student_id]", with: student_id
      fill_in "Password", with: password
      fill_in "Password confirmation", with: password_confirmation
      click_button 'Submit'
    end

    it "can sign up" do
      expect {
        sign_up("123123123", "realpassword", "realpassword")
      }.to change { User.count }.by 1

      expect(User.first.student_id).to eq ("123123123")
      expect(page).to have_content("User was successfully created")
    end

    it "can't sign up with an invalid student ID" do
      sign_up("123431121", "realpassword", "realpassword")
      expect(page).to have_content("Student ID is not valid")
    end

    it "can't sign up with duplicate student_id" do
      FactoryGirl.create :user, student_id: "123123123"
      sign_up("123123123", "realpassword", "realpassword")

      expect(page).not_to have_content "User was successfully created"
      expect(page).to have_content("Oh snap! You got an error!")
      expect(page).to have_content("Student ID has already been taken")
    end
  end

  describe "When logged in" do
    before :each do
      FactoryGirl.create :user
      sign_in(student_id: User.first.student_id, password:"paras")
    end

    it "can change password" do
      visit root_path

      click_link('Change password')
      fill_in("Password", with: "parasta")
      fill_in("Password confirmation", with: "parasta")

      click_button('Submit')

      expect(page).to have_content("User updated successfully")
      click_link("Sign out")

      expect(page).not_to have_content(User.first.student_id)
      sign_in(student_id: User.first.student_id, password:"parasta")
      expect(page).to have_content(User.first.student_id)
    end

    it "can't change other users' passwords" do
      target = FactoryGirl.create :user
      visit edit_user_path(target)

      expect(page).to have_content("This isn't yours to modify!")
    end
   end
end
