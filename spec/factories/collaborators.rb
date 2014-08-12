FactoryGirl.define do
  factory :collaborator do
    name Faker::Name.name
    github_username Faker::Internet.user_name
  end
end
