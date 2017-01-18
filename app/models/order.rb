class Order < ActiveRecord::Base
  PAYMENT_TYPES = ['Cash', 'Credit card', 'Purchase order']

  validates :name, :address, :email, presence: true
  validates :pay_type, inclusion: PAYMENT_TYPES
end
