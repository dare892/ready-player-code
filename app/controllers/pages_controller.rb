class PagesController < ApplicationController
  def index
  
  end
  
  def single
    @challenges = Challenge.where(published: true)
  end
end
