class Rune < ActiveRecord::Base
  validates :uid, presence: true
  validates :name, presence: true
  validates :image_name, presence: true
  validates :description, presence: true
end
