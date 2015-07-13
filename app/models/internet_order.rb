class InternetOrder < ActiveRecord::Base
  has_many :items, :class_name => "OrderItem", :dependent => :destroy
end
