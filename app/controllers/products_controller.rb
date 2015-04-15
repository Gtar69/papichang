class ProductsController < ApplicationController

  def index
    @products = Product.all
  end

  def show
  end

  def add_to_cart
    #binding.pry
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
