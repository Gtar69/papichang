class Kds::ApiController < ApplicationController

  def queue_status
    queues = WaitingQueue.all
    #adding queue process
    #list = Redis::List.new("kds_queue")
    waiting_orders = []
    queues.each do |queue|
      order = Order.find_by_id(queue.order_id)
      waiting_orders << { order_id: order.id, created_at: order.created_at,
                          delivery_method: order.delivery_method, match_method: order.match_method,
                          aasm_state: order.aasm_state, order_items: order.get_items}
    end



    render json: { waiting_orders: waiting_orders }
  end

  #inner queue代表在店內交易的訂單
  def local_queue
    queues = WaitingQueue.all
    #adding queue process
    #list = Redis::List.new("kds_queue")
    waiting_orders = []
    queues.each do |queue|
      order = Order.find_by_id(queue.order_id)
      if order.match_method = "local"
        waiting_orders << { order_id: order.id, created_at: order.created_at,
                            delivery_method: order.delivery_method, match_method: order.match_method,
                            aasm_state: order.aasm_state, order_items: order.get_items}
      end
    end
    render json: { waiting_orders: waiting_orders }
  end

  def internet_queue
    queues = WaitingQueue.all
    #adding queue process
    #list = Redis::List.new("kds_queue")
    waiting_orders = []
    queues.each do |queue|
      order = Order.find_by_id(queue.order_id)
      if order.match_method = "internet"
        waiting_orders << { order_id: order.id, created_at: order.created_at,
                            delivery_method: order.delivery_method, match_method: order.match_method,
                            aasm_state: order.aasm_state, order_items: order.get_items}
      end
    end
    render json: { waiting_orders: waiting_orders }
  end

end