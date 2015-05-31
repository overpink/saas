FactoryGirl.define do
  factory :project do
    tenant
    name Faker::Commerce.product_name
    description Faker::Lorem.sentence
    slug Faker::Internet.slug
  end
end