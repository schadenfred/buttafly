module Buttafly
  class Spreadsheet < ApplicationRecord

    include Originable

    mount_uploader :flat_file, Buttafly::FlatFileUploader

  end
end
