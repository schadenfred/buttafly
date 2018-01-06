class Review < ApplicationRecord

  belongs_to :reviewer, class_name: "User"
  belongs_to :wine
  belongs_to :winery
end
