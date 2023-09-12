FactoryBot.define do
  factory :subscription do
    title { ["Yearly", "Monthly", "Weekly"].sample + " " + Faker::Tea.variety + " Subscription" }
    price { Faker::Commerce.price(range: 0..100.0, as_string: true) }
    status { ["active", "cancelled"].sample }
    frequency { ["Yearly", "Monthly", "Weekly"].sample }
    tea
    customer
  end
end
