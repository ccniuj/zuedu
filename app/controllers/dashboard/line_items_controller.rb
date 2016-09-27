class Dashboard::LineItemsController < DashboardController
  before_action :set_line_item, only: [:edit, :update, :destroy]
  
  def index
    @line_items = LineItem.all.sort
    render json: @line_items
  end

  def edit
    render json: @line_item
  end

  def update
    if @line_item.update line_item_params
      render json: { message: '更新成功' }
    else
      render json: { message: @line_item.errors.full_messages.first }, status: 422
    end
  end

  def destroy
    @line_item.destroy
    render json: { message: '刪除成功' }, status: :ok
  end

  def download
    render json: { csv: LineItem.to_csv(params[:cols]), message: '下載成功' }
  end

  private
    def set_line_item
      @line_item = LineItem.find params[:id]
    end

    def line_item_params
      params.require(:line_items).permit(:product_id, :product_detail_id, :name, :birth, :gender, :ss_number, :school, :grade, :food_preference, :note, :parent_phone_number, :parent_email)
    end
end