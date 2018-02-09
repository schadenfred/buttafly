module Buttafly
  class Spreadsheet < ApplicationRecord

    include Originable

    mount_uploader :flat_file, Buttafly::FlatFileUploader

    # validates :flat_file, presence: true
    validates :name,      uniqueness: true, allow_blank: true
  end
end
