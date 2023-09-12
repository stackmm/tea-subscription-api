FactoryBot.define do
  factory :subscription do
    title { "MyString" }
    price { "9.99" }
    status { "MyString" }
    frequency { "MyString" }
    tea { nil }
    customer { nil }
  end
end
