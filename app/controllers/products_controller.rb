class ProductsController < ApplicationController
  #before_action :authenticate_user!, :except => :index

  def index
    @products = Product.all
  end

  def show 
    @product = Product.find(params[:id])
  end

  def work
  end

  def add_to_cart
    product = Product.find(params[:product_id])
    if current_cart.items.include?(product)
      flash[:info] = "您的購物車內已經有此物品"
    else
      current_cart.items << product
      flash[:info] = "您已經將#{product.name}物品加入購物車!"
    end
    redirect_to products_path
  end

end