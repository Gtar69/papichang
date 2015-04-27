json.array! @orders do |order|
  json.order_id order.id
  json.updated_at order.updated_at
  json.match_method order.match_method
  json.delivery_method order.delivery_method
  json.aasm_state order.aasm_state
  json.order_items order.items, :product_name, :price, :quantity
end

