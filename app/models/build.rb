class Build < ActiveRecord::Base
  validates :title, presence: true
  validates :champion, presence: true
  validates :about, presence: true
  validates :tips, presence: true

  belongs_to :user
  has_many :reviews
  has_many :build_commments
  has_many :masteries_photos
  has_many :runes_photos

  # def self.search(search)
  #   if search.present?
  #     where("name ilike :q or city ilike :q or state ilike :q", q: "%#{search}%")
  #   else
  #     self.all # Needs to be fixed when pagination is done
  #   end
  # end

  def calculate_rating
    if Review.where(build_id: self.id).count > 0
      Review.where(build_id: id).sum(:rating) * 10 / Review.where(build_id: id).count
    else
      0
    end
  end
end
