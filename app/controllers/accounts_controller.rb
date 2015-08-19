class AccountsController < ApplicationController

  #before_action :authenticate_user!

  def management
    #binding.pry
  end

  def update_account
    binding.pry
    #email
    #phone number handling
    #address parese
    #p current_user.id
    #if current_user.address.nil?
    add = Address.new
    add.attributes= Hash[params[:address].map{ |k, v| [k.to_sym, v] }]
    add.save!
    binding.pry
    redirect_to accounts_management_path
  end

end
