class UsersController < ApplicationController
  skip_before_action :login_required, only: [:new, :create]
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to user_path(@user.id)
    else
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to pictures_path, notice: "プロフィールを登録しました！"
    else
      render :edit
    end
  end

  def edit
    @user = User.find(params[:id])
    if current_user.id != @user.id
      redirect_to pictures_path, notice: "他人のプロフィールは編集できません！"
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :image, :image_cache)
  end
end
