Fabricator(:product) do
  name {Faker::Commerce.product_name}
  description {Faker::Lorem.sentence}
end