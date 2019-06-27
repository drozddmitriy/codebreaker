class Game
  include Menu
  include Validation
  include Database
  include Logic
  attr_accessor :code, :input_code, :object
  attr_reader :name, :difficulty, :hints_total, :hints_used, :try, :attempts

  def initialize
    @try = 0
    @object = load
    @hints_used = 0
  end

  def input(attempts)
    begin
      menu_process(attempts, @hints_total)
      puts 'Entery you guess!'.green
      guess = gets.chomp

      return false if guess == 'exit'

      if (guess == 'hint') && @hints_total.positive?
        @hints_total -= 1
        @hints_used += 1
        puts hint(@code)
        message
        next
      end

      if (guess == 'hint') && @hints_total.zero?
        puts 'No hints'.red
        message
        next
      end

      flag = validation_guess(guess)

      if flag
        @input_code = guess
      else
        puts 'Error please enter valid guess'.red
        message
        system 'clear'
      end
    end until flag
  end

  def game_process
    @code = rand_code

    i = 0
    while i <= @attempts
      flag = input(@attempts - i)

      return if flag == false

      @try += 1
      result = check_code(@try, @attempts, @input_code, @code)

      if result == true
        save(to_hash([@name, @attempts, @hints_total, @hints_used, @difficulty, @try]))
        puts 'You win)))!!!'.blue
        message
        return
      elsif result == false
        puts 'You loose((('.red
        message
        return
      else
        i += 1
      end
      puts @code #####################
      print 'Result: '.green
      puts result
      message
    end
  end

  def run
    begin
      system 'clear'
      puts 'Entery you name!'.green
      name = gets.chomp

      return if name == 'exit'

      flag = validation_name(name)

      if flag
        @name = name
      else
        puts 'Error please enter valid name'.red
        message
      end
    end until flag
    difficulty
  end

  def difficulty
    loop do
      menu_choose_difficulty
      difficul = gets.chomp

      case difficul
      when 'easy'
        @difficulty = 'easy'
        @attempts = 15
        @hints_total = 2
        break
      when 'medium'
        @difficulty = 'medium'
        @attempts = 10
        @hints_total = 1
        break
      when 'hell'
        @difficulty = 'hell'
        @attempts = 5
        @hints_total = 1
        break
      when 'exit'
        return
      else
        puts 'Error please choose difficul'.red
        message
        system 'clear'
      end
    end
    game_process
  end
end
