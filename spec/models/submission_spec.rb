describe Submission do

  it "can save a valid submission" do
    FactoryGirl.create :submission
    expect(Submission.count).to eq(1)
  end

  it "cannot save a submission with a bad student id" do
    submission = FactoryGirl.build(:submission, student_id: 123123)
    submission.save
    expect(submission).not_to be_valid
    expect(Submission.count).to eq(0)
  end
end
