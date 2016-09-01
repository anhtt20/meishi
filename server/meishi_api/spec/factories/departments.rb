FactoryGirl.define do
  factory :department do
    sequence(:name) { |n| "Dept #{n}'s name" }
  end
end
