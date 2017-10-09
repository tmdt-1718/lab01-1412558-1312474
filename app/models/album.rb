class Album < ApplicationRecord
  has_many :photos, dependent: :destroy
  belongs_to :user
  mount_uploader :cover, BlogCoverUploader
end
