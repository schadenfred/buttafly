class Review < ApplicationRecord

  belongs_to :reviewer, class_name: "User"
  belongs_to :wine

  validates_uniqueness_of [:reviewer_id, :wine_id]
end
