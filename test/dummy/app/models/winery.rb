class Winery < ApplicationRecord

  has_many :wines
  has_many :reviews, through: :wines
end
