require 'spec_helper'

RSpec.describe Coupon, type: :model do
  let!(:coupon) { create(:coupon) }

  describe 'validations' do
    it { is_expected.to validate_presence_of(:amount) }
    it { is_expected.to validate_presence_of(:coupon_number) }
  end

  describe 'uniqueness' do
    it { is_expected.to validate_uniqueness_of(:coupon_number).case_insensitive }
  end

  describe 'coupon number' do
    it 'generates random six-chars-long coupon number after initialization' do
      coupon = Coupon.new
      expect(coupon.coupon_number).not_to be_nil
      expect(coupon.coupon_number.length).to eq(6)
    end
  end

  describe 'used coupons' do
    it 'updates coupon usage status' do
      coupon.use_coupon
      expect(coupon.used?).to be_truthy
    end
  end
end
