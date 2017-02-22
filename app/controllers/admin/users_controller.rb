class Admin::UsersController < ApplicationController

  before_filter :authenticate_user!
  authorize_resource

  before_filter :load_model, only: [:edit, :show, :update, :destroy]

  def index
    scope = User.all
    scope = scope.where("email ilike :part or first_name ilike :part or last_name ilike :part or phone ilike :part", part: "%#{params[:part]}%") if params[:part].present?
    @users = scope.paginate(page: params[:page], per_page: 20)
  end

  def show
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params, generate_pass: params[:user].try(:[], :generate_pass) == "1"
    if @user.save
      redirect_to admin_users_path, notice: "Пользователь успешно создан"
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @user.update user_params
      redirect_to admin_users_path, notice: "Информация о пользователе обновлена"
    else
      render :edit
    end
  end

  def destroy
    @user.destroy
    redirect_to admin_users_path
  end

  private

  def user_params
    params.require(:user).permit(:manager, :first_name, :last_name, :phone, :email, :password, :password_confirmation, :congregation_id)
  end

  def load_model
    @user = User.find params[:id]
  end

end
