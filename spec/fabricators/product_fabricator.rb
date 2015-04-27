Fabricator(:product) do
  name {Faker::Commerce.product_name}
  description {Faker::Lorem.sentence(3)}
  price {Faker::Commerce.price}
end
