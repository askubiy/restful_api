FactoryGirl.define do
  factory :hotel do
    name {FFaker::Company.name}
    period_booking false
  end
end
