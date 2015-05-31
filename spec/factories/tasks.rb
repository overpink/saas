FactoryGirl.define do
  factory :task do
    project
    status "done"
    content Faker::Lorem.sentence
  end

  trait :iced do
    status "iced"
  end

  trait :todo do
    status "todo"
  end

  trait :archived do
    status "archived" 
  end
end