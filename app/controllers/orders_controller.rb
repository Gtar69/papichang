class OrdersController < ApplicationController
  require 'twilio-ruby'
  #before_action :authenticate_user!

  def index
    #@orders = current_user.orders.order("id DESC")
    @orders = Order.all
  end

  def new
    #binding.pry
    @order= Order.new
  end

  def create
    #binding.pry
    #phone = Phone.where(phone_number: session[:phone_number]).first
    #if phone.nil?
    #  flash[:warning] = " Please get your verify code"
    #  redirct_to order_new_path
    #end

    #if phone.verify_code == params[:order][:verified_phone]
    #binding.pry
      if current_user
        @order = current_user.orders.build
      else
        @order = Order.new
      end

      @order.build_order_item_from_cart(current_cart)
      @order.match_method = params[:match_method]
      @order.delivery_method = params[:delivery_method]
      @order.save
      redirect_to products_path
    #  if @order.save
        #binding.pry
        #PrivatePub.publish_to("/orders/new", message: @order)


        #FayeRails::Controller.publish('/foo', 'wtf it is hard!')

    #    p "finish order"
    #    flash[:warning] = "Thanks for order"
    #    current_cart.clear!
        #phone.update_attribute(:verify_code, SecureRandom.hex(3))
    #    redirect_to products_path

    #  else
    #    flash[:warning] = "That's bad!"
    #    render :new
    #  end

    #else
    #  flash[:warning] = "verify code error and Please get your verify code"
    #  redirect_to new_order_path
    #end

  end

  def certificate_phone
    #需要有檔無效電話的邏輯
    regex = /9\d+/
    phone= Phone.find_by_phone(params[:phone])
    number_to_send_to = "+886" + params[:phone].scan(regex)[0]
    phone.update_attribute(:verify_code, SecureRandom.hex(3) )

    begin
      @twilio_client = Twilio::REST::Client.new ENV["twilio_sid"], ENV["twilio_token"]
      @twilio_client.messages.create(
        :from => "+15012295813",
        :to => number_to_send_to,
        :body => "您的驗證碼為#{phone.verify_code}"
      )
      session[:phone_number] = params[:phone]
      flash[:warning] = '驗證碼已經發出 請檢查您的手機'
    rescue Exception => ex
      flash[:warning] = '您的號碼有誤 請檢查格式是否為 09XXXXXXXX'
      flash[:error] = "An error of type #{ex.class} happened, message is #{ex.message}"
    end
    redirect_to new_order_path
  end



end