require 'rails_helper'

RSpec.describe 'astronauts index page', type: :feature do
  before :each do
    @neil = Astronaut.create(name: "Neil Armstrong", age: 45, job: "moon walker")
    @buzz = Astronaut.create!(name: "Buzz Aldrin", age: 40, job: "spacecraft pilot") 

    visit astronauts_path
  end
  
  it 'displays all of the astronauts' do
    within ("#astronauts") do

      expect(page).to have_content(@neil.name)
      expect(page).to have_content(@buzz.name)
    end
  end

  it 'displays each astronauts age and job' do

    within("#astronaut-#{@neil.id}") do
      expect(page).to_not have_content(@buzz.age)
      expect(page).to_not have_content(@buzz.job)

      expect(page).to have_content(@neil.age)
      expect(page).to have_content(@neil.job)
    end

    within("#astronaut-#{@buzz.id}") do
      expect(page).to_not have_content(@neil.age)
      expect(page).to_not have_content(@neil.job)
      
      expect(page).to have_content(@buzz.age)
      expect(page).to have_content(@buzz.job)
    end
  end

  it 'displays the average age of all astronauts' do
    expected = Astronaut.average_age

    within('#average-age') do
      expect(page).to have_content(expected)
    end
  end
end