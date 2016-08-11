class ApplicantsController < ApplicationController
  before_action :set_applicant, only: [:update]

  def index
    @applicants = current_member.applicants.
      where(product_id: params[:product_id]).
      where(order_id: nil)
    render json: @applicants
  rescue NoMethodError
    render json: { message: '會員尚未登入' }, status: 401
  end

  def update
    if @applicant.update applicant_params
      render json: { message: '更新成功' }, status: :ok
    else
      render json: { message: '更新失敗' }, status: :unprocessable_entity
    end
  end
  
  def destroy
  end

private
  def set_applicant
    @applicant = Applicant.find_by id: params[:id]
  end

  def applicant_params
    params.require(:applicants).permit(:name, :phone_number)
  end
end