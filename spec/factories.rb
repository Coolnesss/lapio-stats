FactoryGirl.define do
  factory :user do
    name "joni"
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
