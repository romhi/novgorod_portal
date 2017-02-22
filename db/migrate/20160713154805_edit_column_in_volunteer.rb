class EditColumnInVolunteer < ActiveRecord::Migration
  def change
    rename_column :volunteers, :service_time_id,  :vacancy_id
  end
end
