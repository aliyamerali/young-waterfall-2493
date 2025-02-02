require 'rails_helper'

RSpec.describe 'Movies show page' do
  before :each do
    @studio = Studio.create!(name: 'Universal Studios', location: 'Hollywood')
    @jurassic = @studio.movies.create!(title: 'Jurassic Park', creation_year: 1993, genre: 'Action/Adventure')
    
    @ford = Actor.create!(name:'Harrison Ford', age: 78, currently_working: false)
    @goldblum = Actor.create!(name:'Jeff Goldblum', age: 68, currently_working: true)
    @dern = Actor.create!(name: 'Laura Dern', age: 54, currently_working: true)
    @myers = Actor.create!(name: "Mike Myers", age: 58, currently_working: false)
    @murphy = Actor.create!(name: "Eddie Murphy", age: 60, currently_working: true)

    @jurassic.actors << @goldblum
    @jurassic.actors << @dern

    visit "/movies/#{@jurassic.id}"
  end

  it 'shows the movie title, creation year, and genre' do
    expect(page).to have_content(@jurassic.title)
    expect(page).to have_content(@jurassic.creation_year)
    expect(page).to have_content(@jurassic.genre)
  end

  it 'shows all the actors in the movie' do
    expect(page).to have_content(@goldblum.name)
    expect(page).to have_content(@dern.name)
    expect(page).to_not have_content(@myers.name)
    expect(page).to_not have_content(@murphy.name)
    expect(page).to_not have_content(@ford.name)
  end

  it 'has a form to add another actor to the movie page' do
    expect(page).to have_field('actor_name')
    expect(page).to have_button("Add Actor to Movie")
  end

  it 'adds an actor to the movie page when one is submitted' do
    fill_in 'Actor Name', with: 'Eddie Murphy'
    click_button 'Add Actor to Movie'

    expect(current_path).to eq("/movies/#{@jurassic.id}")
    expect(page).to have_content(@murphy.name)
  end

end
