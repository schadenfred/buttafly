module FileManipulationSupport

  def write_hash_to_yaml(hash, file, path=nil)
    path ||= "test/support/yaml"
    File.open("#{path}/#{file}.yml", "w+") do |file|
      file.write hash.to_yaml
    end
  end

  def read_hash_from_yaml(file)
    YAML.load_file("test/support/yaml/#{file}.yml")
  end

  def create_file_for_testing(file)
    File.open(file, "w")
  end

  def remove_file_for_testing(file)
    if File.exist?(file)
      FileUtils.rm file
    end
  end

  def file_exists?(directory, pattern=nil)
    directory_files = Dir["#{directory}**/*"]
    directory_files.each do |file|
      name = file.split("/").last
      if name.match pattern
        return true
      end
      false
    end
  end

  def remove_files_for_testing(directory, pattern)
    directory_files = Dir["#{directory}**/*"]
    directory_files.each do |file|
      name = file.split("/").last
      if name.match pattern
        File.delete(file)
      end
    end
  end

  def dummy(file)
    Rails.root.join file
  end

  def engine(file)
    Buttafly::Engine.root.join file
  end

  def sample_csv
    fixture_file_upload(engine('test/samples/reviews.csv') )
  end

  def reset_dummy_app
    substitutions = read_hash_from_yaml("substitutions")
    substitutions.each do |item|
      if item.is_a? String
        remove_file_for_testing(dummy(item))
      else
        remove_line_for_testing(dummy(item.first), item.second)
      end
    end
  end

  def verify_dummy_app_initial_state
    substitutions = read_hash_from_yaml("substitutions")
    substitutions.each do |item|
      if item.is_a? String
        assert_no_file dummy(item)
      else
        File.read(dummy(item.first)).wont_match item.second
      end
    end
  end
end
