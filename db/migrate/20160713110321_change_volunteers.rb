class ChangeVolunteers < ActiveRecord::Migration
  def change
    remove_column :volunteers, :convenient_start_time
    add_column :volunteers, :convenient_start_time, :datetime
    remove_column :volunteers, :convenient_end_time
    add_column :volunteers, :convenient_end_time, :datetime
  end
end
