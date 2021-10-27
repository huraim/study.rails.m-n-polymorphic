class CreateLikes < ActiveRecord::Migration[6.1]
  def change
    create_table :likes do |t|
      t.integer :user_id
      t.integer :post_id
      t.integer :category_id
      t.integer :like_count

      t.timestamps
    end
  end
end
