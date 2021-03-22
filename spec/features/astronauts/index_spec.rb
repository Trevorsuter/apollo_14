require 'rails_helper'

RSpec.describe 'astronauts index page', type: :feature do
  before :each do
    @neil = Astronaut.create(name: "Neil Armstrong", age: 45, job: "moon walker")
    @buzz = Astronaut.create!(name: "Buzz Aldrin", age: 40, job: "spacecraft pilot") 

    @mission1 = Mission.create!(title: "Apollo 1", time_in_space: 10)
    @mission2 = Mission.create!(title: "ISS 9", time_in_space: 150)
    @mission3 = Mission.create!(title: "Jackfire 7", time_in_space: 15)
    @mission4 = Mission.create!(title: "Zebra 4", time_in_space: 15)
    @mission5 = Mission.create!(title: "Kay 10", time_in_space: 15)
    @mission6 = Mission.create!(title: "Gentleman 12", time_in_space: 15)

    AstronautMission.create(astronaut: @neil, mission: @mission1)
    AstronautMission.create(astronaut: @neil, mission: @mission2)
    AstronautMission.create(astronaut: @neil, mission: @mission3)
    AstronautMission.create(astronaut: @neil, mission: @mission4)
    AstronautMission.create(astronaut: @neil, mission: @mission6)
    AstronautMission.create(astronaut: @buzz, mission: @mission6)
    AstronautMission.create(astronaut: @buzz, mission: @mission1)
    AstronautMission.create(astronaut: @buzz, mission: @mission2)
    AstronautMission.create(astronaut: @buzz, mission: @mission4)

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

  it 'displays each astronauts missions' do
    within("#astronaut-#{@neil.id}-missions") do
      expect(page).to_not have_content(@mission5.title)

      expect(page).to have_content(@mission1.title)
      expect(page).to have_content(@mission2.title)
      expect(page).to have_content(@mission3.title)
      expect(page).to have_content(@mission4.title)
      expect(page).to have_content(@mission6.title)
    end
  end

  it 'organizes missions in alphabetical order' do
    within("#astronaut-#{@neil.id}-missions") do
      expect(@mission1.title).to appear_before(@mission6.title)
      expect(@mission6.title).to appear_before(@mission2.title)
      expect(@mission2.title).to appear_before(@mission3.title)
      expect(@mission3.title).to appear_before(@mission4.title)
    end
  end
end