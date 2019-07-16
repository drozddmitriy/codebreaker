class Game
  include ValidationModule
  include LogicModule
  attr_accessor :name, :difficulty, :hints_total, :hints_used, :try, :attempts, :code, :input_code

  def initialize
    @name = false
    @attempts = false
    @try = 0
    @hints_used = 0
    @input_code = false
  end

  def def_name(name)
    return @name = name if validation_name(name)

    false
  end

  def hint
    return 'No hints' if diff_hints.zero?

    @hints_used += 1
    check_hint(@code)
  end

  def def_guess(guess)
    return @input_code = guess if validation_guess(guess)

    false
  end

  def set_difficul(difficulty, attempts, hints_total = 1)
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

  def check
    return true if @input_code == @code

    check_code(@input_code, @code)
  end

  def to_hash
    array = [@name, @attempts, @hints_total, @hints_used, @difficulty, @try]
    keys = %w[name attempts hints_total hints_used difficulty try]
    hash = {}
    keys.zip(array) { |key, val| hash[key.to_sym] = val }
    hash
  end

  def reset_input_code
    @input_code = false
  end
end
