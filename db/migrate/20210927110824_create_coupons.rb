class CreateCoupons < ActiveRecord::Migration[6.1]
  def change
    create_table :coupons do |t|
      t.string :coupon_number, null: false
      t.decimal :amount, precision: 8, scale: 2, null: false
      t.boolean :used, default: false, null: false
      t.boolean :for_present, default: false

      t.index :coupon_number, unique: true
      t.timestamps
    end
  end
end
