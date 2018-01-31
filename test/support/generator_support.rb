module GeneratorSupport

  def gsub_file(path, flag, *args, &block)
    path = File.expand_path(path, destination_root)
    content = File.binread(path)
    content.gsub!(flag, *args, &block)
    File.open(path, "wb") { |file| file.write(content) }
  end

  def remove_line_for_testing(file, line)
    gsub_file(Rails.root.join(file), line, '')
  end
end
