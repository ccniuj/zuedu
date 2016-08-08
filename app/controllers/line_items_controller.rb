class LineItemsController < ApplicationController
  def create
    product = Product.find(params[:product_id])
    CartService.add_product_to_cart(product, current_cart, params[:quantity])
    render json: { message: '已加入購物車' }
  rescue ActiveRecord::RecordNotFound
    render json: { message: '找不到該課程' }
  end

  def destroy
    current_cart.line_items.find(params[:id]).destroy
    render json: { message: '已從購物車移除' }
  rescue ActiveRecord::RecordNotFound
    render json: { message: '購物車內找不到該課程' }
  end
end