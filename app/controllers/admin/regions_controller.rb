class Admin::RegionsController < ApplicationController

  before_action :authenticate_user!
  authorize_resource

  before_action :load_model, only: [:edit, :update, :destroy]

  def index
    @regions = Region.order("name")
  end

  def new
    @region = Region.new
  end

  def create
    @region = Region.new region_params
    if @region.save
      redirect_to admin_regions_path, notice: "Область успешно добавлена!"
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @region.update region_params
      redirect_to admin_regions_path, notice: "Область успешно обновлена!"
    else
      render :edit
    end
  end

  def destroy
    @region.destroy
    redirect_to admin_regions_path, notice: "Область успешно удалена!"
  end

  private

  def load_model
    @region = Region.find params[:id]
  end

  def region_params
    params.require(:region).permit(:name)
  end

end
