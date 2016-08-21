class ProductsController < ApplicationController
  def index
    @products = Product.all
    render json: @products
  end

  def show
    # MemberMailer.welcome_email(current_member).deliver_later
    @product = Product.find_by id: params[:id]
    render json: @product
  end
end