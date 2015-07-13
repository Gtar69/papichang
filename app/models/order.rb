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

  def get_items
    order_items=[]
    items.each do |item|
      product_name = Product.find_by_id(item.product_id).name
      product_id   = item.product_id
      quantity     = item.quantity
    end
    order_items
  end

  def create_with_order_items(order_items)
    order_items.each do |order_item|
      item = items.build 
      item.product_id = order_item["product_id"]
      item.quantity   = order_item["quantity"]
      item.price      = Product.find_by_id(order_item["product_id"]).price
      item.save
    end
  end

  def update_with_order_items(order_items)
    items.delete_all
    order_items.each do |order_item
      item = items.build 
      item.product_id = order_item["product_id"]
      item.quantity   = order_item["quantity"]
      item.price      = Product.find_by_id(order_item["product_id"]).price
      item.save
    end
  end

  def total_price
    items.inject(0) { |sum, item| sum + item.price*item.quantity }
  end

  def serial_number
    "PLD%.6d" % id
  end

  include AASM

  aasm do
    state :order_placed, :initial => true
    state :order_in_delivery
    state :order_paid
    state :order_cancelled

    event :make_delivery do
      transitions :from => :order_placed, :to => :order_in_delivery
    end

    event :make_payment do
      transitions :from => :order_placed, :to => :order_paid
      transitions :from => :order_in_delivery, :to => :order_paid
    end

  end
end