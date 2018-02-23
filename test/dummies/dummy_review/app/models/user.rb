class User < ApplicationRecord
  has_many :wineries_owned, foreign_key: :owner_id
  has_many :wines_made, foreign_key: :winemaker_id
  has_many :reviews, foreign_key: :reviewer_id

  validates_uniqueness_of :name
end
