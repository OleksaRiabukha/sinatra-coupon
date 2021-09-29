FactoryBot.define do
  factory :coupon do
    amount { Faker::Number.decimal(l_digits: 2, r_digits: 2) }
    for_present { false }
    used { false }

    trait :with_coupon_number do
      coupon_number { Faker::Alphanumeric.alphanumeric(number: 6) }
    end
  end
end
