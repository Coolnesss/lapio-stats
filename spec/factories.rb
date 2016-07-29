FactoryGirl.define do

  sequence(:name) { |n| "Example name #{n}" }

  factory :admin, class: User do
    name
    password "best"
    admin true
  end

  factory :user do
    name
    password "paras"
    admin false
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
