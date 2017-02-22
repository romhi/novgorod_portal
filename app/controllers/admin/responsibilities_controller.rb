class Admin::ResponsibilitiesController < ApplicationController

  before_action :authenticate_user!
  authorize_resource

  before_action :load_model, only: [:edit, :update, :destroy]

  def index
    @responsibilities = Responsibility.order("name")
  end

  def new
    @responsibility = Responsibility.new
  end

  def create
    @responsibility = Responsibility.new responsibility_params
    if @responsibility.save
      redirect_to admin_responsibilities_path, notice: "Назначение успешно добавлено!"
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @responsibility.update responsibility_params
      redirect_to admin_responsibilities_path, notice: "Назначение успешно отредактировано!"
    else
      render :edit
    end
  end

  def destroy
    @responsibility.destroy
    redirect_to admin_responsibilities_path, notice: "Назначение успешно удалено!"
  end

  private

  def load_model
    @responsibility = Responsibility.find params[:id]
  end

  def responsibility_params
    params.require(:responsibility).permit(:name)
  end


end
