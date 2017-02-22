class CreateVolunteers < ActiveRecord::Migration
  def change
    create_table :volunteers do |t|
      t.string :first_name
      t.string :last_name
      t.integer :age
      t.integer :responsibility_id
      t.string :phone
      t.string :email
      t.integer :congregation_id
      t.integer :service_time_id
      t.string :convenient_start_time
      t.string :convenient_end_time
      t.integer :will_be_since_8
      t.integer :will_be_until_17
      t.integer :outdoor
      t.integer :car
      t.integer :service_id
      t.text :comment
      t.timestamps null: false
    end
  end
end
