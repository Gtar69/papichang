require 'spec_helper'

RSpec.describe CartItemsController, :type => :controller do

  describe "GET index" do
    before do
      frank = Fabricate(:user)
      session[:user_id] = frank.id
      shrimp_roll = Fabricate(:product)
      rib_eye = Fabricate(:product)
      @cart_item1 = CartItem.create(user: frank, product: shrimp_roll)
      @cart_item2 = CartItem.create(user: frank, product: rib_eye)
      get :index
    end
    it "sets @cart_items" do
      expect(assigns(:cart_items)).to eq([@cart_item1, @cart_item2])
    end

    it "render index template" do
      expect(response).to render_template :index
    end

  end



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
