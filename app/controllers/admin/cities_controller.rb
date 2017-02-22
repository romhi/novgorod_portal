class Admin::CitiesController < ApplicationController

  before_action :authenticate_user!
  authorize_resource

  before_action :load_model, only: [:edit, :update, :destroy]

  def index
    @cities = City.order("name")
  end

  def new
    @city = City.new
  end

  def create
    @city = City.new city_params
    if @city.save
      redirect_to admin_cities_path, notice: "Город успешно добавлен!"
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @city.update city_params
      redirect_to admin_cities_path, notice: "Город успешно обновлен!"
    else
      render :edit
    end
  end

  def destroy
    @city.destroy
    redirect_to admin_cities_path, notice: "Город успешно удален!"
  end

  private

  def load_model
    @city = City.find params[:id]
  end

  def city_params
    params.require(:city).permit(:name, :region_id)
  end

end
