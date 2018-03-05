class StaticController < ApplicationController

  def home
    @reviews = Review.all
  end
end
