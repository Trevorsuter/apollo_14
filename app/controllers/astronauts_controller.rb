class AstronautsController < ApplicationController
  before_action :find_astronauts, only: [:index]
  before_action :find_average_age, only: [:index]
  
  def index
  end

  private
  def find_astronauts
    @astronauts = Astronaut.all
  end

  private
  def find_average_age
    @average_age = Astronaut.average_age
  end
end