require 'spec_helper'

RSpec.describe SessionsController, :type => :controller do
  describe "GET new" do
    it "redirct to home page if current user exists" do
      get :new
      expect(response).to redirect_to root_path
    end
  end

  describe "POST create" do
    context "with valid credentials" do
      before do
        @chris = Fabricate(:user)
        post :create, {email: @chris.email, password: @chris.password}
      end

      it "stores sign in information in the session" do
        expect(session[:user_id]).to eq(@chris.id)
      end

      it "redirects to home page after successful sign in" do
        expect(response).to redirect_to root_path
      end
    end

    context "with invalid credentials" do
      before do
        @chris = Fabricate(:user)
        post :create, email: @chris.email
      end
      it "sets notice" do
        expect(flash[:error]).to eq("Invalid email and password !!!")
      end
      it "goes to sign up path" do
        expect(response).to redirect_to sign_up_path
      end
    end

  end

end