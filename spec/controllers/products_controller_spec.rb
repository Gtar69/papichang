require 'spec_helper'

describe ProductsController, type: :controller do

  describe "GET index" do
    it "sets @products" do
      product_1= Fabricate(:product)
      product_2= Fabricate(:product)
      get :index
      expect(assigns(:products)).to eq([product_1, product_2])
    end

    it "render index template" do
      get :index
      expect(response).to render_template :index
    end
  end

end



