class Movie < ApplicationRecord
  belongs_to :studio
  has_many :castings
  has_many :actors, through: :castings
end
