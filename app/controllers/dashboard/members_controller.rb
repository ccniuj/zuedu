class Dashboard::MembersController < DashboardController
  before_action :set_member, only: [:edit, :update, :destroy]

  def index
    @members = Member.all.sort
    render json: @members
  end

  def edit
    render json: @member
  end

  def update
    if @member.update member_params
      render json: { message: '更新成功' }, status: :ok
    else
      render json: { message: '更新失敗' }, status: :unprocessable_entity
    end
  end

  def destroy
    @member.destroy
    render json: { message: '刪除成功' }, status: :ok
  end

  private
    def set_member
      @member = Member.find params[:id]
    end

    def member_params
      params.require(:members).permit(:name, :email)
    end
end