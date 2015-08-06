class ProductItem < ActiveRecord::Base
	belongs_to :product
	belongs_to :product_attribute
	#這邊設計給 增加產品屬性來使用
end
