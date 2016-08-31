FactoryGirl.define do
  factory :token do
    token "zsR2GcNjUPiHOybIMdrzwwtt"
    expired_time (Time.now + 60*60).to_i
  end
end
