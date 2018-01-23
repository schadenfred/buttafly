include Buttafly

sample_sheets = Dir[File.expand_path('test/samples/*')]

sample_sheets.each_with_index do |sheet, n|
  flat_file = File.open(sheet)
  Buttafly::Spreadsheet.create!(
    name: "cool_file_name-#{n}",
    flat_file: flat_file)
end
