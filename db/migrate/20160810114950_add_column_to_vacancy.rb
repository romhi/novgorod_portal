class AddColumnToVacancy < ActiveRecord::Migration
  def change
    add_column :vacancies, :volunteer_id, :integer
  end
end
