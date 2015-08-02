class Admin::OrdersController < ApplicationController
  #before_action :authenticate_user!
  #before_action :admin_required

  def index
    #出餐準備中 情境 客人點菜/櫃檯input/放入waiting_queue中
    @orders = Order.order("created_at DESC").where(aasm_state: "order_placed")
    #出餐完成 但外送尚未結算之訂單
    @delivery_orders = Order.order("created_at DESC").where(aasm_state: "order_in_delivery")
    #廚房顯示
    @kds_orders = Order.joins(:waiting_queue)
    #所有訂單
    @all_orders = Order.order("created_at DESC").page(1).per(5)
  end

  def edit 
    order = Order.find_by_id(params[:order_id])
    order.update_with_order_items(params[:order_items])
    order.save!
  end

  def make_payment
    order = Order.find_by_id(params[:order_id])
    order.make_payment
    order.save!
    WaitingQueue.where(order_id: params[:order_id]).delete_all  
    flash[:info] = '此訂單出餐完成 已付款'
    redirect_to admin_orders_path
  end

  def make_delivery
    order = Order.find_by_id(params[:order_id])
    order.make_delivery
    order.save!
    WaitingQueue.where(order_id: params[:order_id]).delete_all
    flash[:info] = '此訂單出餐完成 外送中'  
    redirect_to admin_orders_path
  end

  def kds
    queues = WaitingQueue.all
    @waiting_orders = [] 
    queues.each do |queue|
      order = Order.find_by_id(queue.order_id) 
      @waiting_orders << { order_id: order.id, created_at: order.created_at.to_s,
                           delivery_method: order.delivery_method, match_method: order.match_method,
                           aasm_state: order.aasm_state, order_items: order.get_items}
    end
  end
end
