class Order < ActiveRecord::Base
  belongs_to :user
  has_one :waiting_queue
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
      order_items << { product_name: item.product_name, product_id: item.product_id, quantity: item.quantity }
    end
    order_items
  end


  def create_with_order_items(order_items)
    order_items.each do |order_item|
      item = items.build
      product = Product.find_by_id(order_item["product_id"])
      raise "No Such Product: '#{order_item["product_id"]}'" if product.nil?
      raise "#{order_item["quantity"]} Is Not Authorized Quantity " unless order_item["quantity"] >= 1

      if order_item["product_attributes"].nil?
        item.product_name = product.name
        item.quantity     = order_item["quantity"]
        item.price        = Product.find_by_id(order_item["product_id"]).price
      else
        item.product_name = product.name
        item.price = product.price
        order_item["product_attributes"].each do |index|
          product_attr =  ProductAttribute.find_by_id(index)
          item.product_name += "("+ product_attr.name + ")"
          item.price += product_attr.price
        end
        item.product_id   = order_item["product_id"]
        item.quantity     = order_item["quantity"]
      end
      item.save
    end
  end

  def update_with_order_items(order_items)
    #binding.pry
    #order_items = JSON.parse(order_items)
    items.delete_all
    order_items.each do |order_item|
      item = items.build
      product = Product.find_by_id(order_item["product_id"])
      raise "No Such Product: '#{order_item["product_id"]}'" if product.nil?
      raise "#{order_item["quantity"]} Is Not Authorized Quantity " unless order_item["quantity"] >= 1
      item.product_name = product.name
      item.product_id   = order_item["product_id"]
      item.quantity     = order_item["quantity"]
      item.price        = Product.find_by_id(order_item["product_id"]).price
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