class PagesController < ApplicationController
  def home
    @owners = Owner.all
    @animals = Animal.all
  end
end
