class Coupon < ActiveRecord::Base
  after_initialize :generate_coupon

  validates :coupon_number, :amount, presence: true
  validates :coupon_number, uniqueness: true

  def generate_coupon
    self.coupon_number = SecureRandom.alphanumeric(6) if coupon_number.nil?
  end

  def use_coupon
    update(used: true)
  end
end
