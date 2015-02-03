require 'spec_helper'

RSpec.describe UsersController, :type => :controller do

  describe "GET new" do
    it "sets @user variable" do
      get :new
      expect(assigns(:user)).to be_instance_of(User)
    end

    it "renders sign up template" do
      get :new
      expect(response).to render_template :new
    end
  end

  describe "POST create" do
    context "with valid inputs" do
      before do
        post :create, user: {email: Faker::Internet.email, password:
          Faker::Internet.password, full_name: Faker::Name.name}
      end

      it "creates an user" do
        expect(User.count).to eq(1)
      end

      it "redirect to sign in home page after successful create" do
        expect(response).to redirect_to sign_up_path
      end
    end

    context "with invalid inputs" do
      before do
        post :create, user: {email: Faker::Internet.email, password:
          Faker::Internet.password}
      end

      it "can't create any user" do
        expect(User.all.count).to eq(0)
      end

      it "still be in sign up page" do
        expect(response).to render_template :new
      end
    end

  end


end
