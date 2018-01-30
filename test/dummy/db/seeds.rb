require 'byebug'
include Buttafly

sample_sheets = Dir[File.expand_path('test/samples/*')]

sample_sheets.each do |sheet|

  flat_file = File.open(sheet)
  spreadsheet = Buttafly::Spreadsheet.new(
    flat_file: flat_file)
  spreadsheet.save
end
