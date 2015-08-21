class AccountsController < ApplicationController

  before_action :authenticate_user!

  def management

  end

  def update_account
    current_user.email = params[:user][:email]
    current_user.phone_number = params[:user][:phone_number]
    current_user.address = Address.new if current_user.address.nil?
    address = current_user.address
    address.attributes= Hash[params[:address].map{ |k, v| [k.to_sym, v] }]

    if current_user.save && address.save
      flash[:warning] = "You already update your account"
      redirect_to root_path
    else
      render :management
    end
  end


  private

  def user_params
    params.require(:user).permit(:email, :phone_number)
  end

  def address_params
    params.require(:address).permit(:email, :phone_number)
  end
end
