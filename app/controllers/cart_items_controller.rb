class CartItemsController < ApplicationController

  def update
    cart_item = current_cart.cart_items.find(params[:id])
    cart_item.update_attribute(:quantity, params[:cart_item][:quantity])
    redirect_to carts_path
  end

  def destroy
    cart_item = current_cart.cart_items.find(params[:id])
    cart_item.destroy
    redirect_to carts_path
  end

end
