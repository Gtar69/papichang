# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

#Fabricator(:product) do
#  name {Faker::Commerce.product_name}
#  description {Faker::Lorem.sentence(3)}
#  price {Faker::Commerce.price}
  #quantity {(1..5).to_a.sample}
#end

#6.times do
#  Fabricate(:product)
#end

categories = [ {category_name: 'rice'}, {category_name: 'soup'}, {category_name: 'dish'} ]  
               
products=  [ 
             {name: '排骨飯', description: Faker::Lorem.sentence(3), price: Faker::Commerce.price, category_id: 1},
             {name: '香腸飯', description: Faker::Lorem.sentence(3), price: Faker::Commerce.price, category_id: 1},
             {name: '雞腿飯', description: Faker::Lorem.sentence(3), price: Faker::Commerce.price, category_id: 1},
             {name: '鱈魚飯', description: Faker::Lorem.sentence(3), price: Faker::Commerce.price, category_id: 1},
             {name: '魚丸湯', description: Faker::Lorem.sentence(3), price: Faker::Commerce.price, category_id: 2},
             {name: '蝦仁湯', description: Faker::Lorem.sentence(3), price: Faker::Commerce.price, category_id: 2},
             {name: '蝦仁羹', description: Faker::Lorem.sentence(3), price: Faker::Commerce.price, category_id: 2},
             {name: '油豆腐', description: Faker::Lorem.sentence(3), price: Faker::Commerce.price, category_id: 3}, 
             {name: '蝦卷'  , description: Faker::Lorem.sentence(3), price: Faker::Commerce.price, category_id: 3} 
           ]

Category.create(categories)
Product.create(products)