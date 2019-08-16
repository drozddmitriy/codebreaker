module Codebreaker
  module DatabaseModule
    FILE_NAME = 'data.yml'.freeze
    def save(data, path = FILE_NAME)
      file_exist(path)
      File.open(path, 'a') { |file| file.write(data.to_yaml) }
    end

    def load(path = FILE_NAME)
      file_exist(path)
      YAML.load_stream(File.open(path))
    end

    def file_exist(path)
      raise StandardError, I18n.t(:file_not_found) unless File.exist?(path)
    end
  end
end
