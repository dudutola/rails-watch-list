class List < ApplicationRecord
  has_many :bookmarks, dependent: :destroy
  has_many :movies, through: :bookmarks
  has_one_attached :image

  validates :name, presence: true, uniqueness: true
  validate :correct_image_mime_type

  private

  def correct_image_mime_type
    if image.attached? && !image.content_type.in?(%w[image/jpeg image/png])
      errors.add(:image, "must be a JPEG or PNG")
    end
  end
end
