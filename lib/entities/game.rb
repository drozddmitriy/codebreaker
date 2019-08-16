module Codebreaker
  class Game
    include ValidationModule
    include GameHelper
    attr_accessor :player, :difficulty, :hints_total, :hints_used, :try, :attempts, :code, :input_code, :hint_index

    def initialize
      @attempts = false
      @hint_index = []
      @try = 0
      @hints_used = 0
      @input_code = false
    end

    def name_player(name)
      return @player = name if validation_name(name)

      false
    end

    def hint
      @hints_used += 1
      @hint_index = select_unique_hint_index(@hint_index)
      check_hint(@code, @hint_index)
    end

    def guess_player(guess)
      return @input_code = guess if validation_guess(guess)

      false
    end

    def difficulty_player(difficulty, attempts, hints_total = 1)
      @difficulty = difficulty
      @attempts = attempts
      @hints_total = hints_total
    end

    def diff_hints
      @hints_total - @hints_used
    end

    def diff_try
      @attempts - @try
    end

    def set_code
      @code = rand_code
    end

    def add_try
      @try += 1
    end

    def win?
      @input_code == @code
    end

    def check
      check_code(@input_code, @code)
    end

    def to_hash
      array = [@player, @attempts, @hints_total, @hints_used, @difficulty, @try]
      keys = %w[name attempts hints_total hints_used difficulty try]
      hash = {}
      keys.zip(array) { |key, val| hash[key.to_sym] = val }
      hash
    end

    def reset_input_code
      @input_code = false
    end
  end
end
