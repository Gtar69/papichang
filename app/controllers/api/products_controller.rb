class Api::ProductsController < ApplicationController

  def index

    @categories= Category.all

  end

end
