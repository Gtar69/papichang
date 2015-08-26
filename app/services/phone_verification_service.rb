class PhoneVerificationService

  def initialize(user, phone)

  end

  def notfiy_verification!
    number_to_send_to = "+886" + params[:phone].scan(regex)[0]
    @twilio_client = Twilio::REST::Client.new ENV["twilio_sid"], ENV["twilio_token"]
    @twilio_client.messages.create(
      :from => "+886988519755",
      :to => number_to_send_to,
      :body => "您的驗證碼為#{phone.verify_code}"
    )
    #session[:phone_number] = params[:phone]
    flash[:warning] = '驗證碼已經發出 請檢查您的手機'
  end

end