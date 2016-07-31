FactoryGirl.define do

  sequence(:name) { |n| "Example name #{n}" }

  factory :admin, class: User do
    name
    password "best"
    student_id "014475359"
    admin true
  end

  factory :user do
    name
    password "paras"
    admin false
    student_id "014475359"
  end

  factory :week do
    name "First week"
    max_points 100
  end

  factory :submission do
    points 20
    week
    user
  end
end
