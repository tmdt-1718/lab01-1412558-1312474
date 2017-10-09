class Album < ApplicationRecord
  has_many :photos, dependent: :destroy
  belongs_to :user
end
