class Dashboard::CartsController < DashboardController
  before_action :set_cart, only: [:edit, :update, :destroy]
  
  def index
    @carts = Cart.all.sort
    render json: @carts
  end
  def edit
    render json: @cart
  end
  def update
  end
  private
    def set_cart
      @cart = Cart.find params[:id]
    end

    def cart_params
      params.require(:carts).permit(:id)
    end
end