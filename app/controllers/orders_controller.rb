class OrdersController < ApplicationController
  require 'twilio-ruby'

  def index
    # put your own credentials here
    #number_to_send_to = params[:number_to_send_to]

                                                                                       verify_token = SecureRandom.hex(3)

    begin
      @twilio_client = Twilio::REST::Client.new twilio_sid, twilio_token
      @twilio_client.messages.create(
        :from => "+1#{twilio_phone_number}",
        :to => number_to_send_to,
        :body => "您的驗證碼為#{verify_token}"
      )
    rescue Exception => ex
      flash[:error] = "An error of type #{ex.class} happened, message is #{ex.message}"
    end

  end

  def confirm

  end


end
