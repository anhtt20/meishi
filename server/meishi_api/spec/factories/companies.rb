FactoryGirl.define do
  factory :company do
    sequence(:name) { |n| "Company #{n}" }
    sequence(:address) { |n| "Company address #{n}" }
    sequence(:email) { |n| "Company email #{n}" }
    tel "000-0000-0000"
  end
end
