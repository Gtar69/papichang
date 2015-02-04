class CartItem < ActiveRecord::Base
  belongs_to :user
  belongs_to :product

  def name
    product.name
  end
end