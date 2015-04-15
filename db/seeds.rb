# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Fabricator(:product) do
  name {Faker::Commerce.product_name}
  description {Faker::Lorem.sentence(3)}
  price {Faker::Commerce.price}
  #quantity {(1..5).to_a.sample}
end

6.times do
  Fabricate(:product)
end
