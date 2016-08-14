module CartService
  class Error < StandardError; end
  class OrderIsPaid < Error; end
  class CartIsEmpty < Error; end

  module_function

  def add_product_to_cart product, cart, payload={}
    cart.line_items.create!(product: product, unit_price: product.price)
    product.decrement(:inventory).save!
  end

  def create_order_from_cart cart, params
    raise CartIsEmpty, 'Cart is empty' if cart.empty?
    ActiveRecord::Base.transaction do
      order = cart.member.orders.create! params
      cart.line_items.update_all(order_id: order.id, cart_id: nil)
      order
    end
  end

  def create_transaction_from_order order
    if order.paid?
      raise OrderIsPaid, 'A paid order can not create transaction'
    else
      order.transactions.create!
    end
  end

  if Rails.env.development?
    def fetch_transactions order
      order.transactions.where(params: nil).find_each do |transaction|
        transaction.update params: Allpay.client.query_trade_info(transaction.trade_number)
      end
    end
  end
end