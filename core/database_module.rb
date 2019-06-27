module DatabaseModule
  FILE_NAME = 'data.yml'.freeze
  def save(data)
    raise StandardError, 'file not found!' unless File.exist?(FILE_NAME)

    File.open(FILE_NAME, 'a') { |file| file.write(data.to_yaml) }
  end

  def load
    raise StandardError, 'file not found!' unless File.exist?(FILE_NAME)

    YAML.load_stream(File.open(FILE_NAME))
  end
end
