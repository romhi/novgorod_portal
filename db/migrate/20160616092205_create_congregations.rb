class CreateCongregations < ActiveRecord::Migration
  def change
    create_table :congregations do |t|
      t.string :name
      t.integer :number
      t.integer :city_id

      t.timestamps null: false
    end
  end
end
