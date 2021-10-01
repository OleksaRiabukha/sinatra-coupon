class Coupon < ActiveRecord::Base
  validates :coupon_number, :amount, presence: true
  validates :coupon_number, uniqueness: { case_sensitive: false }

  after_initialize :generate_coupon

  def generate_coupon
    return unless coupon_number.nil?

    generated_coupon_number = SecureRandom.alphanumeric(6).downcase

    generate_coupon if Coupon.where(coupon_number: generated_coupon_number).present?

    self.coupon_number = generated_coupon_number
  end

  def use_coupon
    update(used: true)
  end
end
