json.array! @categories do |category|
  json.category category.category_name
  json.products category.products, :id, :name, :price
end