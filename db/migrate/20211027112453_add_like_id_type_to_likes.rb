class AddLikeIdTypeToLikes < ActiveRecord::Migration[6.1]
  def change
    add_column :likes, :like_id, :integer
    add_column :likes, :like_type, :text
  end
end
