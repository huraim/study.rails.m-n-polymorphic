class Post < ApplicationRecord
  has_many :replies

  belongs_to :category
  belongs_to :user
end
