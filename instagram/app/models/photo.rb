class Photo < ApplicationRecord
  belongs_to :post

# adding this to make sure photo is not created without an image
  validates :image, presence: true


  mount_uploader :image, PhotoUploader
end
