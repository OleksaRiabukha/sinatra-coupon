FactoryBot.define do
  factory :coupon do
    coupon_number { Faker::Alphanumeric.alphanumeric(number: 6) }
    amount { Faker::Number.decimal(l_digits: 2, r_digits: 2) }
    for_present { false }
    used { false }
  end
end
