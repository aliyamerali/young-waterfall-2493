require 'rails_helper'

RSpec.describe 'Studios show page' do
  before :each do
    @studio = Studio.create!(name: 'Universal Studios', location: 'Hollywood')
    @lost_ark = @studio.movies.create!(title: 'Raiders of the Lost Ark', creation_year: 1981, genre: 'Action/Adventure')
    @jurassic = @studio.movies.create!(title: 'Jurassic Park', creation_year: 1993, genre: 'Action/Adventure')
    @shrek = @studio.movies.create!(title: 'Shrek', creation_year: 2001, genre: 'Comedy/Fantasy')

    @ford = Actor.create!(name:'Harrison Ford', age: 78, currently_working: false)
    @lost_ark.actors << @ford

    @goldblum = Actor.create!(name:'Jeff Goldblum', age: 68, currently_working: true)
    @dern = Actor.create!(name: 'Laura Dern', age: 54, currently_working: true)
    @jurassic.actors << @goldblum
    @jurassic.actors << @dern
    @lost_ark.actors << @dern
    @shrek.actors << @dern

    @myers = Actor.create!(name: "Mike Myers", age: 58, currently_working: false)
    @murphy = Actor.create!(name: "Eddie Murphy", age: 60, currently_working: true)
    @shrek.actors << @myers
    @shrek.actors << @murphy

    visit "/studios/#{@studio.id}"
  end

  it 'shows the studio name and location' do
    expect(page).to have_content(@studio.name)
    expect(page).to have_content(@studio.location)
  end

  it 'shows the titles of all the movies at the studio' do
    expect(page).to have_content(@lost_ark.title)
    expect(page).to have_content(@jurassic.title)
    expect(page).to have_content(@shrek.title)
  end

  # I see a list of actors that have acted in any of the studio's movies
  # And I see that the list of actors only includes actors that are currently working
  it 'shows a list of *currently working* actors in the studios movies' do
    expect(page).to have_content(@goldblum.name)
    expect(page).to have_content(@dern.name)
    expect(page).to have_content(@murphy.name)
    expect(page).to_not have_content(@ford.name)
    expect(page).to_not have_content(@myers.name)
  end

  # And I see that the list of actors is unique (no duplicate actors)
  it 'does not show duplicate actors' do
    expect(page).to have_content(@dern.name, count: 1)
  end

  # And I see that the list of actors is ordered from oldest actor to youngest
  it 'orders actors from oldest to youngest' do
    expect(@goldblum).to appear_before(@murphy)
    expect(@murphy).to appear_before(@dern)
  end


end
