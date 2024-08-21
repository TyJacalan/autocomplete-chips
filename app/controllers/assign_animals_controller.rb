class AssignAnimalsController < ApplicationController
  def create
    owner_id = params[:owner_id]
    animal_names = params[:animal_names].split(",")

    owner = Owner.find(owner_id)
    animals = Animal.where(name: animal_names)

    animals.each do |animal|
      animal.update(owner: owner)
    end

    redirect_to root_path, notice: "Pets successfully assigned to #{owner.name}."
  end
end
