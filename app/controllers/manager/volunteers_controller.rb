class Manager::VolunteersController < ApplicationController

  before_filter :authenticate_user!
  authorize_resource

  before_filter :load_model, only: [:edit, :show, :update, :destroy]

  def index
    @congregation = current_user.congregation
    @volunteers = Volunteer.by_congregation_id(@congregation.id)
  end

  def show
  end

  def new
    @volunteer = Volunteer.new
  end

  def create
    @volunteer = current_user.congregation.volunteers.build params_volunteer
    if @volunteer.save
      redirect_to manager_volunteers_path, notice: "Доброволец успешно создан!"
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @volunteer.update params_volunteer
      redirect_to manager_volunteers_path, notice: "Информация о добровольце обновлена"
    else
      render :edit
    end
  end

  def destroy
    if @volunteer.vacancy.present?
      redirect_to manager_volunteers_path, alert: "Нельзя удалить уже назначенного добровольца! Напишите Администратору!" if @volunteer.vacancy.present?
    else
      @volunteer.destroy
      redirect_to manager_volunteers_path, notice: "Доброволец успешно удален!"
    end
  end

  def print
    @congregation = current_user.congregation
    @volunteers = Volunteer.by_congregation_id(@congregation.id)
    render layout: false
  end

  private

  def params_volunteer
    params.require(:volunteer).permit( :last_name, :first_name, :age, :service_time_id,
                                      :convenient_start_time, :convenient_end_time, :will_be_since_8, :car,
                                      :will_be_until_17, :outdoor, :phone,:email, :comment, :responsibility_id)
  end

  def load_model
    @volunteer = Volunteer.find params[:id]
  end

end
