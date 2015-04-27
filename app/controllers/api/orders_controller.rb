class Api::OrdersController < ApplicationController

  def index
    @orders = Order.all
  end

  def today_orders
    @orders = Order.all
  end


  def create
    @order = Order.new
    @order.delivery_method = params[:delivery_method]
    @order.match_method    = params[:match_method]

    params[:order_items].each do |order_item_data|
      product = Product.find(order_item_data[:product_id])
      item = @order.items.build
      item.product_name = product.name
      item.price = product.price
      item.quantity = order_item_data[:quantity]
      item.save!
    end

    if @order.save
      render json: @order, status: 201
    else

    end
  end


  #Time.now.strftime("%F") + "-"
  def update
    @order = Order.find(params[:order_id])
    @order.delivery_method = params[:delivery_method]
    @order.match_method    = params[:match_method]
    @order.items.delete_all
    params[:order_items].each do |order_item_data|
      product = Product.find(order_item_data[:product_id])
      item = @order.items.build
      item.product_name = product.name
      item.price = product.price
      item.quantity = order_item_data[:quantity]
      item.save!
    end

    if @order.save
      render json: @order, status: 201
    else

    end

  end

end
