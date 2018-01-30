module FileManipulationSupport

  def hash_to_yaml(hash, file, path=nil)
    path ||= "test/support/yaml/files"
    File.open("#{path}/#{file}.yml", "w+") do |file|
      file.write hash.to_yaml
    end
  end

  def hash_from_yaml(file)
    YAML.load_file("test/support/yaml/#{file}.yml")
  end
end
