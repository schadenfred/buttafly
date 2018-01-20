module FileManipulationHelpers
  def gsub_file(path, flag, *args, &block)
    config = args.last.is_a?(Hash) ? args.pop : {}

    path = File.expand_path(path, destination_root)
    content = File.binread(path)
    content.gsub!(flag, *args, &block)
    File.open(path, "wb") { |file| file.write(content) }
  end

  def remove_line(file, line)
    gsub_file(Rails.root.join(file), line, '')
  end

  def dummy(file)
    Rails.root.join file
  end
end
