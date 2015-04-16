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

  def total_price
    items.inject(0) { |sum, item| sum + item.price*item.quantity }
  end



end
