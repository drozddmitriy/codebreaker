module Codebreaker
  module StatisticModule
    def sort_player(load_database)
      load_database.sort_by { |value| [value[:attempts], value[:try], value[:hints_used]] }
    end
  end
end
