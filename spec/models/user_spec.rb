describe User do
  it "cannot save a user with a short student id" do
    user = FactoryGirl.build(:user, student_id: 123123)
    user.save
    expect(user).not_to be_valid
    expect(User.count).to eq(0)
  end

  it "cannot save a submission with an invalid student id" do
    user = FactoryGirl.build(:user, student_id: "123123124")
    user.save
    expect(user).not_to be_valid
    expect(User.count).to eq(0)
  end
end
