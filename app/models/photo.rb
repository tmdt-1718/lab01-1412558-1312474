class Photo < ApplicationRecord
  belongs_to :albums
  belongs_to :user
end
