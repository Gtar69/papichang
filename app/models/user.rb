class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :orders
  #validates_uniqueness_of :email
  validates_presence_of :phone
  validate :phone_format


  def phone_format
    errors.add(:phone, "電話號碼要符合 ex: 0988322683 的形式") if /^09\d{8}/.match(phone).nil?
  end

end
