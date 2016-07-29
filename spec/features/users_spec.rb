require 'rails_helper'

describe "User" do

  describe "When not logged in" do

    def sign_up(username, password, password_confirmation)
      visit signup_path

      fill_in "Name", with: username
      fill_in "Password", with: password
      fill_in "Password confirmation", with: password_confirmation
      click_button 'Submit'
    end

    it "can sign up" do

      expect {
        sign_up("Best", "realpassword", "realpassword")
      }.to change { User.count }.by 1

      expect(User.first.name).to eq ("Best")
      expect(page).to have_content("User was successfully created")
    end

    it "can't sign up with duplicate name" do
      FactoryGirl.create :user, name: "Duplicate"
      sign_up("Duplicate", "realpassword", "realpassword")

      expect(page).not_to have_content "User was successfully created"
      expect(page).to have_content("Oh snap! You got an error!")
      expect(page).to have_content("Name has already been taken")
    end
  end

  describe "When logged in" do
    before :each do
      FactoryGirl.create :user
      sign_in(name: User.first.name, password:"paras")
    end

    it "can change password" do
      visit root_path

      click_link('Change password')
      fill_in("Password", with: "parasta")
      fill_in("Password confirmation", with: "parasta")

      click_button('Submit')

      expect(page).to have_content("User updated successfully")
      click_link("Sign out")

      expect(page).not_to have_content(User.first.name)
      sign_in(name: User.first.name, password:"parasta")
      expect(page).to have_content(User.first.name)
    end

    it "can't change other users' passwords" do
      target = FactoryGirl.create :user, name: "target"
      visit edit_user_path(target)

      expect(page).to have_content("This isn't yours to modify!")
    end
   end
end
