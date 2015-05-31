FactoryGirl.define do
  factory :tenant do 
    name Faker::Company.name
    slug Faker::Internet.slug
  end
end