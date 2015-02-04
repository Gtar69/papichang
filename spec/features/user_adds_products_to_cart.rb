# encoding: utf-8
require "spec_helper"

feature "user_adds_products_to_cart" do
  scenario "user add 3 products to cart and then press " do
    rib_eye = Fabricate(:product, name: "rib")
    5.times {Fabricate(:product)}
    sign_in
    find("a[href='/cart_items?product_id=#{rib_eye.id}']").click
    click_link "Checkout"
    expect(page).to have_content rib_eye.name
  end
end

