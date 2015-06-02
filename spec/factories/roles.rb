FactoryGirl.define do
  factory :role do
    name Faker::Lorem.word
  end

  trait :owner do
    name "owner"
  end
end