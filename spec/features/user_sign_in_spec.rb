require "spec_helper"

feature "user sign in " do
  scenario "with valid email and passowrd" do
    alice = Fabricate(:user)
    sign_in(alice)
    page.should have_content alice.full_name
  end
end