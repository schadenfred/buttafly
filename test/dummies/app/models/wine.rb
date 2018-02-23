class Wine < ApplicationRecord

  belongs_to :winemaker, class_name: "User"
  belongs_to :winery
  has_many :reviews

  validates :name, presence: true

  validates_uniqueness_of [:name, :winery]
end
