require "buttafly/engine"

module Buttafly
  require 'carrierwave'
  require 'jquery-rails'
  require 'bootstrap'
  require 'haml-rails'
  require 'aasm'

  class << self
    mattr_accessor :blacklisted_models, :carrierwave_storage_dir,
                   :carrierwave_storage_type, :flat_file_col, :originable_model,
                   :whitelisted_models 


    self.originable_model = "Buttafly::Spreadsheet"
    self.flat_file_col = "flat_file"
    self.whitelisted_models = []

    self.blacklisted_models = []
    self.carrierwave_storage_type = :file
    self.carrierwave_storage_dir = %q["uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"]
  end

  def self.setup(&block)
    yield self
  end
end
