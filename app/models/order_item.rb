class OrderItem < ActiveRecord::Base
  belongs_to :order
  belongs_to :internet_order
end
