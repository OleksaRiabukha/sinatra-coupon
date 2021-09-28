FactoryBot.define do
  factory :coupon do
    coupon_number { SecureRandom.alphanumeric(6) }
    amount { Faker::Number.decimal(l_digits: 2, r_digits: 2) }
  end
end
