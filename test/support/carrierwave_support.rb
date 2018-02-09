require 'fileutils'

# Carrierwave setup and teardown
carrierwave_template = Buttafly::Engine.root.join('test','samples')
carrierwave_root = Buttafly::Engine.root.join.join('test','support','carrierwave')

# Carrierwave configuration is set here instead of in initializer
CarrierWave.configure do |config|
  config.root = carrierwave_root
  config.enable_processing = false
  config.storage = :file
  config.cache_dir = Buttafly::Engine.root.join('test','support','carrierwave','carrierwave_cache')
end

# And copy carrierwave template in
#puts "Copying\n  #{carrierwave_template.join('uploads').to_s} to\n  #{carrierwave_root.to_s}"
FileUtils.cp_r carrierwave_template.join('uploads'), carrierwave_root

# at_exit do
#   #puts "Removing carrierwave test directories:"
#   Dir.glob(carrierwave_root.join('*')).each do |dir|
#     #puts "   #{dir}"
#     FileUtils.remove_entry(dir)
#   end
# end
