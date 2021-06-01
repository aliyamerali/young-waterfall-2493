require 'rails_helper'

RSpec.describe Movie do
  describe 'relationships' do
    it {should belong_to :studio}
    it {should have_many :castings}
    it {should have_many(:actors).through(:castings)}
  end

  before :each do
    @studio = Studio.create!(name: 'Universal Studios', location: 'Hollywood')
    @lost_ark = @studio.movies.create!(title: 'Raiders of the Lost Ark', creation_year: 1981, genre: 'Action/Adventure')
    @jurassic = @studio.movies.create!(title: 'Jurassic Park', creation_year: 1993, genre: 'Action/Adventure')
    @shrek = @studio.movies.create!(title: 'Shrek', creation_year: 2001, genre: 'Comedy/Fantasy')

    @ford = Actor.create!(name:'Harrison Ford', age: 78, currently_working: false)
    @goldblum = Actor.create!(name:'Jeff Goldblum', age: 68, currently_working: true)
    @dern = Actor.create!(name: 'Laura Dern', age: 54, currently_working: true)
    @myers = Actor.create!(name: "Mike Myers", age: 58, currently_working: false)
    @murphy = Actor.create!(name: "Eddie Murphy", age: 60, currently_working: true)

    @lost_ark.actors << @ford
    @jurassic.actors << @goldblum
    @jurassic.actors << @dern
    @lost_ark.actors << @dern
    @shrek.actors << @dern
    @shrek.actors << @myers
    @shrek.actors << @murphy
  end

  describe 'class methods' do
    it '.working_actors_by_age returns actors where working = true, ordered by age oldest to youngest, without repeats' do
      expect(Movie.working_actors_by_age.first.name).to eq(@goldblum.name)
      expect(Movie.working_actors_by_age.last.name).to eq(@dern.name)
      expect(Movie.working_actors_by_age.count).to eq(3)
    end
  end
end
