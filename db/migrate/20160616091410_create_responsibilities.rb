class CreateResponsibilities < ActiveRecord::Migration
  def change
    create_table :responsibilities do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
