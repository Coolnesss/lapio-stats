FactoryGirl.define do
  sequence(:student_id, (0..3).cycle) { |n| ["123123123", "014475359", "123321129", "123322128"][n] }

  factory :admin, class: User do
    password "best"
    student_id
    admin true
  end

  factory :user do
    password "paras"
    admin false
    student_id
  end

  factory :week do
    name "First week"
    max_points 100
    deadline 2.days.from_now
  end

  factory :submission do
    points 20
    week
    user
  end
end
