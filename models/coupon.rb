class Coupon < ActiveRecord::Base
  after_initialize :generate_coupon

  validates :coupon_number, :amount, presence: true
  validates :coupon_number, uniqueness: { case_sensitive: false }

  def generate_coupon
    return unless coupon_number.nil?

    generated_coupon_number = SecureRandom.alphanumeric(6).downcase

    if Coupon.where(coupon_number: generated_coupon_number).exists?
      generate_coupon
    else
      self.coupon_number = generated_coupon_number
    end
  end

  def use_coupon
    update(used: true)
  end
end
