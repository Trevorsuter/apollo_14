require 'rails_helper'

describe Astronaut, type: :model do
  before :each do
    @neil = Astronaut.create(name: "Neil Armstrong", age: 45, job: "moon walker")
    @buzz = Astronaut.create!(name: "Buzz Aldrin", age: 40, job: "spacecraft pilot") 
    @trevor = Astronaut.create!(name: "Trevor Suter", age: 35, job: "ground support")

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
  end

  describe 'Validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :age }
    it { should validate_presence_of :job }
  end

  describe 'Relationships' do
    it { should have_many :astronaut_missions}
    it { should have_many :missions}
  end

  describe 'class methods' do
    it 'average_age' do
      expected = (@neil.age + @buzz.age + @trevor.age) / 3

      expect(Astronaut.average_age).to eq(expected)
    end
  end

  describe 'instance methods' do
    it 'ordered_missions_by_title' do
      neil_expected = [@mission1, @mission6, @mission2, @mission3, @mission4]
      buzz_expected = [@mission1, @mission6, @mission2, @mission4]
      trevor_expected = []

      expect(@neil.ordered_missions_by_title).to eq(neil_expected)
      expect(@buzz.ordered_missions_by_title).to eq(buzz_expected)
      expect(@trevor.ordered_missions_by_title).to eq(trevor_expected)
    end

    it 'total_spacetime' do
      neil_expected = @neil.missions.sum do |mission|
        mission.time_in_space
      end
      buzz_expected = @buzz.missions.sum do |mission|
        mission.time_in_space
      end

      expect(@neil.total_spacetime).to eq(neil_expected)
      expect(@buzz.total_spacetime).to eq(buzz_expected)
    end
  end
end
