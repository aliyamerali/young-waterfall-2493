require 'rails_helper'

RSpec.describe 'Studios show page' do
  before :each do
    @studio = Studio.create!(name: 'Universal Studios', location: 'Hollywood')
    @lost_ark = @studio.movies.create!(title: 'Raiders of the Lost Ark', creation_year: 1981, genre: 'Action/Adventure')
    @jurassic = @studio.movies.create!(title: 'Jurassic Park', creation_year: 1993, genre: 'Action/Adventure')
    @shrek = @studio.movies.create!(title: 'Shrek', creation_year: 2001, genre: 'Comedy/Fantasy')

    visit "/studios/#{@studio.id}"
  end
# I see the studio's name and location
# And I see the titles of all of its movies

  it 'shows the studio name and location' do
    expect(page).to have_content(@studio.name)
    expect(page).to have_content(@studio.location)
  end

  it 'shows the titles of all the movies at the studio' do
    expect(page).to have_content(@lost_ark.title)
    expect(page).to have_content(@jurassic.title)
    expect(page).to have_content(@shrek.title)
  end

end
