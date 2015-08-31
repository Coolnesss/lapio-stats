require 'rails_helper'

describe "User" do

  before :each do
    FactoryGirl.create :user
    sign_in(name:"joni", password:"paras")
  end

  it "can change password" do
    visit root_path

    click_link('Change password')
    fill_in("Password", with: "parasta")
    fill_in("Password confirmation", with: "parasta")

    click_button('Submit')

    expect(page).to have_content("User updated successfully")
    click_link("Sign out")

    expect(page).not_to have_content("joni")
    sign_in(name:"joni", password:"parasta")
    expect(page).to have_content("joni")
  end
end
