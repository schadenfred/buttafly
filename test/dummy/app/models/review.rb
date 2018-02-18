class Review < ApplicationRecord

  belongs_to :reviewer, class_name: "User"
  belongs_to :wine

  validates :content, presence: true
  validates :content, uniqueness: true
  validates_uniqueness_of [:reviewer_id, :wine_id]
end
