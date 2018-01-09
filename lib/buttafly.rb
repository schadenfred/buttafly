require "buttafly/engine"

module Buttafly
  require 'haml-rails'

  class << self
    mattr_accessor :originable_model, :testingvar
    self.originable_model = "Spreadsheet"
    self.testingvar = "coolness"
  end

  def self.setup(&block)
    yield self
  end

end
