require 'rails_helper'

RSpec.describe 'Studios show page' do
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

    @shrek.actors << @myers
    @shrek.actors << @murphy
    @shrek.actors << @dern
    @jurassic.actors << @goldblum
    @jurassic.actors << @dern
    @lost_ark.actors << @dern
    @lost_ark.actors << @ford

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

  it 'shows a list of *currently working* actors in the studios movies' do
    expect(page).to have_content(@goldblum.name)
    expect(page).to have_content(@dern.name)
    expect(page).to have_content(@murphy.name)
    expect(page).to_not have_content(@ford.name)
    expect(page).to_not have_content(@myers.name)
  end

  it 'does not show duplicate actors' do
    expect(page).to have_content(@dern.name, count: 1)
  end

  it 'orders actors from oldest to youngest' do
    expect(@goldblum.name).to appear_before(@murphy.name)
    expect(@murphy.name).to appear_before(@dern.name)
  end


end
