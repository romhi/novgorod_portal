class Admin::CongregationsController < ApplicationController

  before_action :authenticate_user!
  authorize_resource

  before_action :load_model, only: [:edit, :update, :destroy]

  def index
    @congregations = Congregation.order(:name)
  end

  def new
    @congregation = Congregation.new
  end

  def create
    @congregation = Congregation.new congregation_params
    if @congregation.save
      redirect_to admin_congregations_path, notice: "Собрание успешно создано!"
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @congregation.update congregation_params
      redirect_to admin_congregations_path, notice: "Собрание успешно обновлено!"
    else
      render :edit
    end
  end

  def destroy
    @congregation.destroy
    redirect_to admin_congregations_pathб notice: "Собрание успешно удалено!"
  end

  private

  def load_model
    @congregation = Congregation.find params[:id]
  end

  def congregation_params
    params.require(:congregation).permit(:name, :number, :city_id)
  end


end
