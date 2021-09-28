class Coupon < ActiveRecord::Base

  validates :coupon_number, :amount, presence: true
  validates :coupon_number, uniqueness: true

  def generate_coupon
    self.coupon_number = SecureRandom.alphanumeric(6)
  end

  def use_coupon
    used = true
    update(used: used)
  end
end
