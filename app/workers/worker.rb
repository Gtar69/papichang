


  def create_orders(shop,orders,import_id)
    at 50  #start with 50
    error_message = ""
    orders.each_with_index do |order,index|
      begin
        pct = ((50*index/orders.size) + 50)
        at pct
        _order = shop.orders.create_with_products(order[:order].merge({import_id: import_id,:shipping_info =>order[:shipping]}),order[:products])
      rescue Exception => ex
        puts "--- import order Excetion : #{ex}--------"
        error_message +=  "訂單#{order[:order][:name]}: " + ex.message + "<BR>"
      end
    end
    store :error_message => error_message
  end

  def create_with_products(order={}, products=[])
      shop = @association.owner
      _order = nil
      if products.blank?
        return false
      end
      if shop.orders.where(:barcode => order[:barcode]).present?
        raise "BARCODE"
      end
      
      ActiveRecord::Base.transaction do
        _order = shop.orders.create(order)
        products.each do |product|
          unless _order.add_item(product[:uid], product[:quantity]) == true
            raise "NO PRODUCT"
          end
        end
      end
      if _order.shippings.empty?
        _order.shipping_type = Shipping::Type::HONEYCOMB_DEFAULT
        _order.save
        _order.create_shipping
      end
      _order
    end
  end

  def add_item(uid, quantity)
    product = shop.products.where(:uid => uid).first
    if product
      self.products.create({:product => product, :quantity => quantity})
    elsif (bundle = shop.bundles.where(:uid => uid).first).present?
      products = bundle.products
      products.each do |bundle_product|
        self.products.create({:product_id => bundle_product.product_id, :bundle_id => bundle.id, :quantity => quantity*bundle_product.quantity})
      end
    else
      return false
    end
    true
  end


