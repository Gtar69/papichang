class Admin::OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :admin_required

  def index
    @orders = Order.all
  end

  def make_payment
    @order = Order.find(params[:order_id])
    @order.make_payment
    @order.save!
    flash[:info] = '此訂單已經付款'
    redirect_to admin_orders_path
  end

  def make_delivery
    @order = Order.find(params[:order_id])
    @order.make_delivery
    @order.save!
    redirect_to admin_orders_path
  end

  def kds
    @order = Order.all.limit(6)
  end

end
