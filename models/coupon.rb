class Coupon < ActiveRecord::Base

  validates :coupon_number, :amount, presence: true

  def generate_coupon
    self.coupon_number = SecureRandom.alphanumeric(16)
  end

  def use_coupon
    used = true
    update(used: used)
  end
end
