FactoryGirl.define do
  factory :user, aliases: [:author] do
    sequence(:email){ |n| "awesome_email_#{n}@pm.com"} 
    password "imawesome"
    password_confirmation "imawesome"
  end
end