class Order < ActiveRecord::Base
  belongs_to :user
  has_many :items, :class_name => "OrderItem", :dependent => :destroy

  def build_order_item_from_cart(cart)
    cart.cart_items.each do |cart_item|
      item = items.build
      item.product_name = cart_item.product.name
      item.price = cart_item.product.price
      item.quantity = cart_item.quantity
      item.save
    end
  end


  def build_order_item_from_api(order_items)

  end

  def total_price
    items.inject(0) { |sum, item| sum + item.price*item.quantity }
  end


  def serial_number
    "-%.6d" % id
  end

  include AASM

  aasm do
    state :order_placed, :initial => true
    state :order_paid
    state :order_cancelled
    event :make_payment do
      transitions :from => :order_placed, :to => :order_paid
    end
  end
end
