class Product < ActiveRecord::Base
  validates_presence_of :name, :description
  belongs_to :category


  def self.category(name)
    category = Category.where(category_name: name)
    Product.where(category: category)
  end


end
