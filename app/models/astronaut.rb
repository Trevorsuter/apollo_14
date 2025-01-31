class Astronaut < ApplicationRecord
  validates_presence_of :name, :age, :job
  has_many :astronaut_missions
  has_many :missions, through: :astronaut_missions

  def self.average_age
    average(:age)
  end

  def ordered_missions_by_title
    missions.order(:title)
  end

  def total_spacetime
    missions.sum(:time_in_space)
  end
end
