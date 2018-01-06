class Wine < ApplicationRecord

  belongs_to :winery
  has_many :reviews
end
