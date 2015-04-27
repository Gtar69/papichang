class Phone < ActiveRecord::Base
  validates_presence_of :phone_number
  validates_uniqueness_of :phone_number
  #validates_length_of :phone_number, is: 9, message: "Your Phone number should be represented as 0988519755"


  def self.find_by_phone(number)
    phone = Phone.where(phone_number: number).first

    if !phone.nil?
      phone
    else
      if true
        Phone.create(phone_number: number)
      else
        flash[:error] = "Your Phone number should be represented as 0988519755"
      end
    end

  end



  private

    def verify_phone_number_format?
      true
    end

end
