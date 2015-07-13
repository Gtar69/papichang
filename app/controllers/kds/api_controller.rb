class Kds::ApiController < ApplicationController

  def queue_status
    queues = WaitingQueue.all.limit(6)  
    #出餐準備中
    waiting_orders = [] 
    queues.each do |queue|
      order = Order.find_by_id(queue.order_id) 
      waiting_orders << order.get_items
    end
    render json: {waiting_orders: waiting_orders}
  end


end