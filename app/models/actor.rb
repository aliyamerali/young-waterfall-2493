class Actor < ApplicationRecord
  has_many :castings
  has_many :movies, through: :castings

  def coactors
    movie_ids = movies.pluck(:id)
    Movie.joins(:actors)
         .select('actors.name')
         .where('movies.id' => movie_ids)
         .where.not("actors.id = #{self.id}")
         .distinct
         .order('actors.name')
  end

end
