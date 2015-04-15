class CartsController < ApplicationController

  def index
  end


  def checkout
    @order = current_user.orders.build
    # @information of order 電話
  end

end
