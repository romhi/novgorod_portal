class CreateVacancies < ActiveRecord::Migration
  def change
    create_table :vacancies do |t|
      t.string :name
      t.datetime :starts_at
      t.datetime :ends_at
      t.text :comment

      t.timestamps null: false
    end
  end
end
