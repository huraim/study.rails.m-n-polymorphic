class RenameAdminToUser < ActiveRecord::Migration[6.1]
  def change
    rename_column :users, :admin, :is_admin
  end
end
