class Photo < ApplicationRecord
  belongs_to :albums
  belongs_to :user
  mount_uploader :cover, BlogCoverUploader
end
