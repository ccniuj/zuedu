class LineItemsController < ApplicationController
  before_action :set_line_item, only: [ :update ]

  def index
    @line_items = current_cart.line_items
    render json: @line_items
  end

  def create
    product = Product.find(params[:product_id])
    CartService.add_product_to_cart(product, current_cart)
    render json: { message: '已加入購物車' }
  rescue ActiveRecord::RecordNotFound
    render json: { message: '找不到該課程' }
  end

  def update
    if @line_item.update line_item_params
      render json: { message: '新增成功' }
    else
      render json: { message: '新增失敗' }
    end
  end

  def destroy
    current_cart.line_items.find(params[:id]).destroy
    render json: { message: '已從購物車移除' }
  rescue ActiveRecord::RecordNotFound
    render json: { message: '購物車內找不到該課程' }
  end

private
  def set_line_item
    @line_item = LineItem.find_by id: params[:id]
  end

  def line_item_params
    params.require(:line_items).permit(:product_id, :name, :birth, :gender, :ss_number, :school, :grade, :food_preference, :note)
  end
end