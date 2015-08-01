describe Week do

  it "can save a valid Week" do
    FactoryGirl.create :week
    expect(Week.count).to eq(1)
  end

  it "cannot save a week without a name" do
    week = FactoryGirl.build(:week, name: nil)
    week.save
    expect(week).not_to be_valid
    expect(Week.count).to eq(0)
  end

  it "cannot save a week without max points" do
    week = FactoryGirl.build(:week, max_points: nil)
    week.save
    expect(week).not_to be_valid
    expect(Week.count).to eq(0)
  end

end
