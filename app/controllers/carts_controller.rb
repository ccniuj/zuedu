class CartsController < ApplicationController
  def index
    render json: current_cart
  end
end