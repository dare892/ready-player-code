class PagesController < ApplicationController
  access :user => [:single],
         :all => :all
  def index
  
  end
  
  def single
    @challenges = Challenge.all.order(:difficulty)
  end
end
