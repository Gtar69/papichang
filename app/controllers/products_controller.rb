class ProductsController < ApplicationController
  #before_action :require_user
  def index
    @products = Product.limit(6)
  end
end
