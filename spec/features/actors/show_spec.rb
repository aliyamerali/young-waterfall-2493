require 'rails_helper'

RSpec.describe 'Actors show page' do
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

    @jurassic.actors << @dern
    @lost_ark.actors << @dern
    @shrek.actors << @myers
    @shrek.actors << @murphy
    @jurassic.actors << @goldblum
    @lost_ark.actors << @ford

    visit "/actors/#{@dern.id}"
  end

  it 'shows the actors name and age' do
    expect(page).to have_content(@dern.name)
    expect(page).to have_content(@dern.age)
  end

  it 'shows a list of actors this actor has worked with' do
    expect(page).to have_content(@ford.name)
    expect(page).to have_content(@goldblum.name)
    expect(page).to_not have_content(@myers.name)
    expect(page).to_not have_content(@murphy.name)
  end

end
