class CartItemsController < ApplicationController
  before_action :require_user


  def index
    @cart_items = current_user.cart_items
  end

  def create
    product = Product.find(params[:product_id])
    cart_item_product(product)
    redirect_to root_path
  end

  def destroy
  end

  def remove
    product = Product.find(params[:product_id])
    remove_product(product)
    redirect_to root_path
  end


  private

  def remove_product(product)
    if current_user_has_product?(product)
      CartItem.where(user: current_user, product: product).first.destroy!
    end
  end

  def cart_item_product(product)
    CartItem.create!(user: current_user, product: product) unless current_user_has_product?(product)
  end

  def current_user_has_product?(product)
    current_user.cart_items.map{|cart_item| cart_item.product}.include?(product)
  end

end
