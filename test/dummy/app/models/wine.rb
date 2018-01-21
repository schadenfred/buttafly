class Wine < ApplicationRecord

  belongs_to :winemaker, class_name: "User"
  belongs_to :winery
  has_many :reviews
end
