class CartsController < ApplicationController
  before_action :authenticate_user!
  def index
  end

  def update_cart_content
    ActiveRecord::Base.transaction do
      params[:cart_items].each do |cart_item|
        #cart_item = CartItem.find(cart_item_data[:id])
        #cart_item.update_attributes!(position: queue_item_data[:position], rating: queue_item_data[:rating])
      end
    end
  end

end