class Order < ActiveRecord::Base
  PAYMENT_TYPES = ['Cash', 'Credit card', 'Purchase order']
end
