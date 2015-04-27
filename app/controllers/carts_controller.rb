class CartsController < ApplicationController
  #before_action :authenticate_user!
  def index
  end

  def update_cart_content
    #"cart_items"=>[{"id"=>"1", "quantity"=>"8"}, {"id"=>"2", "quantity"=>"9"}]
    update_cart_items
    redirect_to new_order_path
  end

  private

  def update_cart_items
    ActiveRecord::Base.transaction do
      params[:cart_items].each do |cart_item_data|
        cart_item = CartItem.find(cart_item_data[:id])
        #verify quantiy logic
        cart_item.update_column(:quantity, cart_item_data[:quantity].to_i)
      end
    end
  end

end