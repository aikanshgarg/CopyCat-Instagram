class Like < ApplicationRecord
  belongs_to :post
  belongs_to :user

# so that user can like a post only once
  validates :user_id, uniqueness: {scope: :post_id}
end
