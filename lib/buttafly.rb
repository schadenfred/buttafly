require "buttafly/engine"

module Buttafly
  require 'haml-rails'

  class << self
    mattr_accessor :originable_model, :whitelisted_models, :blacklisted_models
    self.originable_model = "Spreadsheet"
    self.whitelisted_models = []
    self.blacklisted_models = []
  end

  def self.setup(&block)
    yield self
  end

end
