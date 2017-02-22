class AddColumnToMessages < ActiveRecord::Migration
  def change
    add_column :messages, :author_id, :integer
    add_column :messages, :user_read, :integer
    add_column :messages, :admin_read, :integer
  end
end
