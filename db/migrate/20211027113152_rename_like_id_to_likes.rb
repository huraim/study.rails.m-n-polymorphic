class RenameLikeIdToLikes < ActiveRecord::Migration[6.1]
  def change
    rename_column :likes, :like_id, :item_id
    rename_column :likes, :like_type, :item_type
    rename_column :likes, :like_count, :item_count
  end
end
