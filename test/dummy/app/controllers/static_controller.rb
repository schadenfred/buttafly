class StaticController < ApplicationController

  def home
    @models = get_models
  end

  private

  def get_models
    %w(user wine winery blacklisted)
  end
end
