class AddColumnToVacancies < ActiveRecord::Migration
  def change
    add_column :vacancies, :number, :string
  end
end
