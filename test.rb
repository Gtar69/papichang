	require 'rest-client'
require 'uri'
require 'json'

url = "http://localhost:3000"
#{ 
#   “delivery_method” :  “local“, 
#   “match_method”    :  “local“, 
#   “order_items“ : [ { “product_id”:  3 , “quantity”: 8 } , { … }, { … } ]  
#} 
=begin
_url = url + "/kds/api/queue_status"
response = RestClient.get _url
p JSON.parse(response.force_encoding("UTF-8"))
=end

=begin
_url = url + "/pos/api/create_order"

order_items = [] 
order_items << { product_id:  2 , quantity: 5 }
order_items << { product_id:  1 , quantity: 6 }
order_items << { product_id:  1 , quantity: 1, product_attributes: [5,9] }
order_items << { product_id:  3 , quantity: 3 }
response = RestClient.post _url, delivery_method: "delivery", match_method: "local",  order_items: order_items.to_json
p response.code
p response
=begin
#patch “/pos/api/update_orders/” 

#{ 
#   “order_id”: 703
#   “delivery_method”: “local“ 
#   “match_method”: “internet“
#   “ order_items“: [ { ““product_id”:  5 , “quantity”: 6} , { … }, { … } ] 
#}
=end

_url = url + "/pos/api/update_order"
order_items = [] 
order_items << { product_id:  1 , quantity: 10}
order_items << { product_id:  4 , quantity: 8 }
order_items << { product_id:  5 , quantity: 9 }

RestClient.post _url, delivery_method: "local", match_method: "local",  order_items: order_items.to_json, order_id: 54


=begin
#_url = url + "/pos/api/confirm_order"

#RestClient.post _url, order_id: 11
_url = url + "/pos/api/cancel_order"

RestClient.delete _url, {:params => {:order_id => 7}}
=end

_url = url + "/pos/api/get_orders"
response = RestClient.get _url, {:params => {:page_number => 1}}
p JSON.parse(response.force_encoding("UTF-8"))
