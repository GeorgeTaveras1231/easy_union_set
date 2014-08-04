# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :project do
    title { Faker::Hacker.noun }
    description { Faker::Lorem.sentence }
    category { Faker::Company.bs }
  end
end
