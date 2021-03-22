require 'rails_helper'

describe Astronaut, type: :model do
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
    before :each do
      @neil = Astronaut.create(name: "Neil Armstrong", age: 45, job: "moon walker")
      @buzz = Astronaut.create!(name: "Buzz Aldrin", age: 40, job: "spacecraft pilot") 
      @trevor = Astronaut.create!(name: "Trevor Suter", age: 35, job: "ground support")
    end

    it 'average_age' do
      expected = (@neil.age + @buzz.age + @trevor.age) / 3

      expect(Astronaut.average_age).to eq(expected)
    end
  end
end
