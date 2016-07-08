class Dashboard::ProductsController < DashboardController
  def index
    @products = Product.all
    render json: @products
  end
end