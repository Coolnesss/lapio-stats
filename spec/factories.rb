FactoryGirl.define do

  sequence(:name) { |n| "Example name #{n}" }

  factory :user do
    name
    password "paras"
  end

  factory :week do
    name "First week"
    max_points 100
  end

  factory :submission do
    student_id "014475359"
    points 20
    week
    user
  end
end
