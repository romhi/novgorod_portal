class CitiesController < ApplicationController

  before_filter :authenticate_user!

  def index
    @cities = City.all
  end

end
