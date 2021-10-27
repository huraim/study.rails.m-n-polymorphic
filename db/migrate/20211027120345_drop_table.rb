class DropTable < ActiveRecord::Migration[6.1]
  def change
    drop_table :likes
    drop_table :privacies
  end
end
