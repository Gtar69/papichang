class User < ActiveRecord::Base
  validates_presence_of :email, :password, :full_name
  validates_uniqueness_of :email
  has_secure_password
  has_many :cart_items

  def has_product?(product)
    cart_items.map(&:product).include?(product)
  end
end