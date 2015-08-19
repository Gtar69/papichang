class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable

  has_many :orders
  #validates_uniqueness_of :email
  #validates_presence_of :phone
  #validate :phone_format


  def phone_format
    errors.add(:phone, "電話號碼要符合 ex: 0988322683 的形式") if /^09\d{8}/.match(phone).nil?
  end

  def self.find_for_facebook_oauth2(access_token, signed_in_resource=nil)
      data = access_token.info
      user = User.where(:provider => access_token.provider, :uid => access_token.uid ).first

      p data

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
