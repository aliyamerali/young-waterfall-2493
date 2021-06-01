class Movie < ApplicationRecord
  belongs_to :studio
  has_many :castings
  has_many :actors, through: :castings

  def self.working_actors_by_age
    joins(:actors)
    .select('actors.*')
    .where('currently_working = ?', true)
    .distinct
    .order(age: :desc)
  end

end
