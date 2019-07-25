module DatabaseModule
  FILE_NAME = 'data.yml'.freeze
  def save(data, path = FILE_NAME)
    file_exist?(path)
    File.open(path, 'a') { |file| file.write(data.to_yaml) }
  end

  def load(path = FILE_NAME)
    file_exist?(path)
    YAML.load_stream(File.open(path))
  end

  def file_exist?(path)
    raise StandardError, 'file not found!' unless File.exist?(path)
  end

  def sort_player(load_database)
    load_database.sort_by { |value| [value[:attempts], value[:try], value[:hints_used]] }
  end
end
