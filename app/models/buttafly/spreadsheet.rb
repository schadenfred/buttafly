module Buttafly
  class Spreadsheet < ApplicationRecord

    include Originable

    mount_uploader :flat_file, Buttafly::FlatFileUploader

    validates :name,      uniqueness: true, allow_blank: true
  end
end
