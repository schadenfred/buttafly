require "buttafly/engine"

module Buttafly
  require 'carrierwave'
  require 'jquery-rails'
  require 'bootstrap'
  require 'haml-rails'

  class << self
    mattr_accessor :originable_model, :whitelisted_models, :blacklisted_models,
      :carrierwave_storage_type, :carrierwave_storage_dir

    self.originable_model = "Buttafly::Spreadsheet"
    self.whitelisted_models = []
    self.blacklisted_models = []
    self.carrierwave_storage_type = :file
    self.carrierwave_storage_dir = %q["uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"]
  end

  def self.setup(&block)
    yield self
  end
end
