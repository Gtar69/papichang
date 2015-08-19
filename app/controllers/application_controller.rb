class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  #protect_from_forgery with: :exception
  protect_from_forgery with: :null_session
  #before_action :authenticate_user!
  #skip_before_filter :verify_authenticity_token#, :only => :create

  def admin_required
    current_user.is_admin
  end

  def current_cart
    if session[:cart_id]
      Cart.find(session[:cart_id])
    else
      cart = Cart.create
      session[:cart_id] = cart.id
      cart
    end
  end

  helper_method :current_cart


end
