class Searches::AnimalsController < ApplicationController
  def index
    query = params[:query]
    animals = Animal.where("name ILIKE ?", "%#{query}%").limit(3)
    render json: animals.pluck(:name)
  end
end
