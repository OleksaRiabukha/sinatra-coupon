class CouponSerializer < BaseSerializer
  attributes :id, :coupon_number, :amount, :used, :for_present
end
