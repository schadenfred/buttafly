require 'byebug'
include Buttafly


legend = Buttafly::Legend.create(
  data: {
    "review"=>{
      "rating"=>"rating",
      "content"=>"review content",
      "reviewer"=>{
        "name"=>"reviewer name",
        "age"=>"",
        "astrological_sign"=>""
      },
      "wine"=>{
        "name"=>"wine name",
        "vintage"=>"vintage",
        "winemaker"=>{
          "name"=>"winemaker name",
          "age"=>"",
          "astrological_sign"=>""
        },
        "winery"=>{
          "name"=>"winery name",
          "mission"=>"",
          "history"=>"",
          "owner"=>{
            "name"=>"winery owner",
            "age"=>"",
            "astrological_sign"=>""
          }
        }
      }
    }
  },
  targetable_model: "review",
  originable_headers: ["wine name", "winemaker name", "winery name", "vintage",
    "review content", "rating", "winery owner", "reviewer name"],
  name: "default"
)
# sample_sheets.each do |sheet|
sheets = Dir[File.expand_path('../samples/*.csv')]
#
sheets.each do |sheet|
  flat_file = File.open(sheet)
  spreadsheet = Buttafly::Spreadsheet.new(
    name: "sweet ass spreadsheet",
    flat_file: flat_file)
  spreadsheet.save
end

Buttafly::Mapping.create(legend: legend, originable: Buttafly::Spreadsheet.last)
