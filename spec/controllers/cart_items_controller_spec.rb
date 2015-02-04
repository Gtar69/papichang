require 'spec_helper'

RSpec.describe CartItemsController, :type => :controller do

  describe "POST create" do
    before do
      @frank = Fabricate(:user)
      @shrimp_roll = Fabricate(:product)
      session[:user_id] = @frank.id
      post :create, user: @frank, product_id: @shrimp_roll.id
    end

    it "creates a cart item" do
      expect(CartItem.all.count).to eq(1)
    end

    it "creates a cart item asscoicated with current user" do
      expect(CartItem.first.user).to eq(@frank)
    end

    it "creates a cart item associated with specific product" do
      expect(CartItem.first.product).to eq(@shrimp_roll)
    end

    it "redirects to root path" do
      expect(response).to redirect_to root_path
    end
  end

  describe "DELETE cart_item" do
    it "removes cart_item of current user" do
      frank = Fabricate(:user)
      shrimp_roll = Fabricate(:product)
      session[:user_id] = frank.id
      CartItem.create(product: shrimp_roll, user: frank)
      delete :remove, product_id: shrimp_roll.id
      expect(frank.cart_items.count).to eq(0)
    end
  end

end
