class Pos::ApiController < ApplicationController
  protect_from_forgery with: :null_session

  #查詢單張訂單(GET)

  def get_order
    order = Order.find_by_id(params[:order_id])
    render json: { order_id: order.id, created_at: order.created_at, updated_at: order.updated_at, delivery_mehtod: order.delivery_method,
      match_method: order.match_method, assm_state: order.assm_state, order_items: order.get_items }
  end

  def get_orders
    # tell me page_number
    order_collection = []
    orders = Order.order("created_at DESC").page(params[:page_number].to_i).per(5)
    orders.each do |order|
      order_items = []
      order.items.each do |order_item|
        order_items << { product_name: order_item.product_name, quantity: order_item.quantity, price: order_item.price }
      end
      order_collection << { order_id: order.id, created_at: order.created_at, updated_at: order.updated_at,
                            delivery_method: order.delivery_method, match_method: order.match_method,
                            aasm_state: order.aasm_state, order_items: order_items }
    end
    render json: {order_collection: order_collection}
  end

  #建立訂單(POST)
  def create_order
    begin
      order = Order.new(delivery_method: params[:delivery_method], match_method: params[:match_method])
      order.create_with_order_items(JSON.parse(params[:order_items]))
      WaitingQueue.create(order_id: order.id)
      order.save!
      render json: {message: 'ok', price: order.total_price}
    rescue Exception => ex
      render json: {message: "#{ex.message}"}
    end
  end

  #更改訂單(Patch)
  def update_order
    begin
      order = Order.find_by_id(params[:order_id])
      order.update_with_order_items(params[:order_items])
      render json: {message: 'ok', price: order.total_price}
    rescue Exception => ex
      render json: {message: "#{ex.message}"}
    end
  end

  #取消訂單(DELETE)
  def cancel_order
    #check params
    order = Order.find_by_id(params[:order_id]).delete
    WaitingQueue.where(order_id: params[:order_id]).delete_all
    render json: {message: 'ok'}
  end

  #結賬步驟(POST)/已出餐
  def confirm_order
    order = Order.find_by_id(params[:order_id])
    #binding.pry
    order.update_column(:aasm_state, "order_paid")
    WaitingQueue.where(order_id: params[:order_id]).delete_all
    render json: {message: 'ok'}
  end

  private

  def check_order_params
    return false if params[:delivery_method].nil? || params[:match_method].nil? || params[:order_items].nil?
    true
  end

end