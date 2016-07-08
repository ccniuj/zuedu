class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # protect_from_forgery with: :exception
  protect_from_forgery
  skip_before_action :verify_authenticity_token, if: -> { request.format.symbol == :json }
  before_action :set_cart

  def set_cart
    session[:cart_id] ||= Cart.create.id
  end

  def current_cart
    Cart.find(session[:cart_id])
  end
end
