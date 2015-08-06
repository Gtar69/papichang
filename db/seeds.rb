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
=begin
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
=end
product_attributes= [ 
                      { name: '切',   price: 0, product_id: 1 },
                      { name: '不切',  price: 0, product_id: 1 },
                      #米飯 => 正常, 飯少, 加飯(+5, +10)
                      { name: '飯少' ,price: 0, product_id: 1 },
                      { name: '加飯5元', price: 5, product_id: 1},
                      { name: '加飯10元', price: 10, product_id: 1},
                      #滷汁 => 正常, 汁多,汁少, 要汁不要肉
                      { name: '滷汁汁少', price: 0, product_id: 1 },
                      { name: '滷汁汁多', price: 0, product_id: 1 },
                      { name: '要汁不要肉',price: 0, product_id: 1},
                      #炸 => 正常, 酥炸
                      { name: '酥炸', price: 0, product_id: 1}
                      #控肉 => 正常, 瘦肉, 肥肉
                      #{ name: 'pork_belly', value: nil, price: 0 },
                      #豬腳 => 正常, 皮多, 肉多, 腳蹄 
                      #{ name: 'pork_knuckle', value: nil, price: 0 }
                    ]

ProductAttribute.create(product_attributes)


