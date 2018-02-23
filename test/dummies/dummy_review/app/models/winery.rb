class Winery < ApplicationRecord

  belongs_to :owner, class_name: "User"

  has_many :wines
  has_many :reviews, through: :wines

  validates_uniqueness_of :name
end
