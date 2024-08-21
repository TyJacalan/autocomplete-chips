class PagesController < ApplicationController
  def home
    @owners = Owner.all
    @animals = Animal.pluck(:name).to_json
  end
end
