class Wine < ApplicationRecord

  belongs_to :owner, class_name: "User"
  belongs_to :winery
  has_many :reviews
end
