class User < ActiveRecord::Base
  acts_as_token_authenticatable
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable
  has_many :orders
  has_one :address
  #before_update :phone_format
  validate :phone_format
  validates_presence_of :email
  #before_update :phone_format
  #attr_accessor :phone_number
  #validates_format_of :phone_number, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, :on => :update_atrribute
  #validates_uniqueness_of :email
  #validates_presence_of :phone
  #validate :phone_format

  def phone_format
    if /^09\d{8}/.match(phone_number).nil?
      errors.add(:phone_number, "電話號碼要符合 ex: 0988519755 的形式")
    end
    #binding.pry
    return !(/^09\d{8}/.match(phone_number).nil?)
  end

  def self.find_for_facebook_oauth2(access_token, signed_in_resource=nil)
      data = access_token.info
      user = User.where(:provider => access_token.provider, :uid => access_token.uid ).first
      if user
        return user
      else
        registered_user = User.where(:email => access_token.info.email).first
        if registered_user
          return registered_user
        else
          user = User.create(
            name: data["name"],
            provider:access_token.provider,
            email: data["email"],
            uid: access_token.uid ,
            password: Devise.friendly_token[0,20],
          )
        end
     end
  end

end
