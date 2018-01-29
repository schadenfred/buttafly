module GeneratorsTestHelper

  def generate_sample_app
    system "rails new dummy --skip-active-record --skip-test-unit --skip-spring --skip-bundle"
  end

  def gsub_file(path, flag, *args, &block)
    path = File.expand_path(path, destination_root)
    content = File.binread(path)
    content.gsub!(flag, *args, &block)
    File.open(path, "wb") { |file| file.write(content) }
  end

  def remove_line_for_testing(file, line)
    gsub_file(Rails.root.join(file), line, '')
  end

  def remove_file_for_testing(file)
    if File.exist?(dummy(file))
      FileUtils.rm dummy(file)
    end
  end

  def dummy(file)
    Rails.root.join file
  end

  def reset_dummy_app
    substitutions = YAML.load_file("test/support/substitutions.yml")
    substitutions.each do |item|
      if item.is_a? String
        remove_file_for_testing(item)
      else
        remove_line_for_testing(dummy(item.first), item.second)
      end
    end
  end

  def verify_dummy_app_initial_state
    substitutions = YAML.load_file("test/support/substitutions.yml")
    substitutions.each do |item|
      if item.is_a? String
        assert_no_file dummy(item)
      else
        File.read(dummy(item.first)).wont_match item.second
      end
    end
  end

  def read_from_yaml(file)
     YAML.load_file("test/support/#{file}_ancestors.yml")
  end
end
