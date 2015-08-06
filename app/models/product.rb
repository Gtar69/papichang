class Product < ActiveRecord::Base
  validates_presence_of :name, :description
  validates_uniqueness_of :name   
  belongs_to :category
   
  has_many :product_attributes  
  #has_many :items, :through => :product_items, :source => :product_attribute
  #has_many :product_items

  def self.category(name)
    category = Category.where(category_name: name)
    Product.where(category: category)
  end


end
