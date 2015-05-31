FactoryGirl.define do
  factory :comment do
    author
    content Faker::Lorem.sentence
  end
end