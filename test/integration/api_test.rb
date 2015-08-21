require 'test_helper'

class  ApiTest < ActionDispatch::IntegrationTest

  setup do
    6.times { Fabricate(:product) }
  end

  test "sign in" do
  #test "index with token authentication via query params" do
    get :index, { user_email: "alice@example.com", user_token: "1G8_s7P-V-4MGojaKD7a" }
    assert_response :success
  #end
  end


  test "create order" do

    order_items =  [{ product_id:  3 , quantity: 8 } , { product_id:  4 , quantity: 20 }]
    post '/api/orders', { delivery_method: "to_go", match_method: "local", order_items: order_items }.to_json,
    {'Accept' => Mime::JSON.to_s, 'Content-Type' => Mime::JSON.to_s }
    assert_equal 201, response.status
    assert_equal 2, Order.find(1).items.count
    assert_equal "to_go", Order.find(1).delivery_method

  end


  test "edit existed order" do
    order_items =  [{ product_id:  3 , quantity: 8 } , { product_id:  4 , quantity: 20 }]
    post '/api/orders', { delivery_method: "to_go", match_method: "local", order_items: order_items }.to_json,
    {'Accept' => Mime::JSON.to_s, 'Content-Type' => Mime::JSON.to_s }

    order_items = [ { product_id:  3 , quantity: 28 } ]

    patch 'api/orders/1', { order_id: 1, delivery_method: "stay_in", match_method: "local", order_items: order_items }.to_json,
    {'Accept' => Mime::JSON.to_s, 'Content-Type' => Mime::JSON.to_s }
    #assert_equal 201, response.status
    assert_equal 1, Order.find(1).items.count
    assert_equal "stay_in", Order.find(1).delivery_method

  end



end

