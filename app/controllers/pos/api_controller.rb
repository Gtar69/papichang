class Pos::ApiController < ApplicationController

  #查詢訂單(GET)
  def get_order
    order = Order.find_by_id(params[:order_id])    
    render json: { order_id: order.id, created_at: order.created_at, updated_at: order.updated_at, delivery_mehtod: order.delivery_method, 
      match_method: order.match_method, assm_state: order.assm_state, order_items: order.get_items }
  end

  #查詢多筆訂單 每次十筆
  def get_orders
    #pagination 
    @orders = Order.today
  end

  #建立訂單(POST)
  def create_order
    order = Order.create(delivery_method: params[:delivery_method], match_method: params[:match_method])
    order.create_with_order_items(params[:order_items])
    #放入出餐準備中
    WaitingQueue.create(order_id: order_id)
    #放入redis or database? or double check
    render json: {message: 'ok', price: order.total_price}
  end

  #更改訂單(Patch)
  def update_order
    order = Order.find_by_id(params[:order_id])
    order.update_with_order_items(params[:order_items])
    render json: {message: 'ok', price: order.total_price}
  end

  #取消訂單(DELETE)
  def cancel_order
    order = Order.find_by_id(params[:order_id])
    WaitingQueue.where(order_id: params[:order_id]).delete_all
    order.delete
    render json: {message: 'ok'}
  end

  #結賬步驟(POST)/已出餐
  def confirm_order
    order = Order.find_by_id(params[:order_id])
    order.upadte_column(:status, "finished")
    render json: {message: 'ok'}
  end


end