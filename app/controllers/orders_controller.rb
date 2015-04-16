class OrdersController < ApplicationController
  require 'twilio-ruby'
  before_action :authenticate_user!

  def index
    @orders = current_user.orders.order("id DESC")
  end

  def new
    @order= Order.new
  end

  def create
    if current_user.verify_token == params[:order][:order_verify]
      @order = current_user.orders.build
      @order.build_order_item_from_cart(current_cart)
      @order.delivery_method = params[:delivery]
      if @order.save
        flash[:warning] = "感謝您的訂購 將於20分鐘後完成你的訂單"
        current_cart.clear!
        current_user.update_attribute(:verify_token, SecureRandom.hex(3))
        redirect_to orders_path
      else
        flash[:warning] = "That's bad!"
        render :new
      end
    else
      flash[:warning] = "您的驗證碼錯誤 請輸入正確驗證碼或重新獲取驗證碼"
      redirect_to new_order_path
    end

  end

  def certificate_phone
    #需要有檔無效電話的邏輯
    regex = /9\d+/
    number_to_send_to = "+886" + params[:phone].scan(regex)[0]
    current_user.update_attribute(:verify_token, SecureRandom.hex(3) )

    begin
      @twilio_client = Twilio::REST::Client.new ENV["twilio_sid"], ENV["twilio_token"]
      @twilio_client.messages.create(
        :from => "+15012295813",
        :to => number_to_send_to,
        :body => "您的驗證碼為#{current_user.verify_token}"
      )
      flash[:warning] = '驗證碼已經發出 請檢查您的手機'
    rescue Exception => ex
      flash[:warning] = '您的號碼有誤 請檢查格式是否為 09XXXXXXXX'
      flash[:error] = "An error of type #{ex.class} happened, message is #{ex.message}"
    end
    redirect_to new_order_path
  end



end