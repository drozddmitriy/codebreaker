class Game
  include MenuModule
  include ValidationModule
  include DatabaseModule
  include LogicModule
  attr_accessor :code, :input_code, :data
  attr_reader :name, :difficulty, :hints_total, :hints_used, :try, :attempts

  def initialize
    @name = false
    @try = 0
    @hints_used = 0
    @input_code = false
    @data = load
  end

  def registration
    until @name
      system 'clear'
      puts 'Entery you name!'.green
      name = gets.chomp

      return false if name == 'exit'

      set_values(validation_name(name), name, 'name')
    end
  end

  def set_values(valid, set_val, name)
    if valid
      @name = set_val if name == 'name'
      @input_code = set_val if name == 'guess'
      return
    end

    puts "Error please enter valid #{name}".red
    MenuModule.message
  end

  def check_difficulty
    loop do
      menu_choose_difficulty
      difficul = gets.chomp

      case difficul
      when 'easy'
        set_difficul('easy', 15, 2)
        break
      when 'medium'
        set_difficul('medium', 10, 1)
        break
      when 'hell'
        set_difficul('hell', 5, 1)
        break
      when 'exit'
        return false
      else
        puts 'Error please choose difficul'.red
        MenuModule.message
      end
    end
  end

  def set_difficul(difficulty, attempts, hints_total)
    @difficulty = difficulty
    @attempts = attempts
    @hints_total = hints_total
  end

  def game_process
    @code = rand_code

    i = 0
    while i <= @attempts
      return if input(@attempts - i) == false

      @try += 1
      result = check_code(@try, @attempts, @input_code, @code)

      if result == true
        puts "Secret code: #{@code}".green
        puts 'You win)))!!!'.blue
        puts 'Do you want to save the result? [y/n]'.green
        flag = gets.chomp
        save(to_hash([@name, @attempts, @hints_total, @hints_used, @difficulty, @try])) if flag == 'y'
        MenuModule.message
        return
      end

      if result == false
        puts "Secret code: #{@code}".green
        puts 'You loose((('.red
        MenuModule.message
        return
      end
      puts @code ##################
      print 'Result:'.green
      puts result
      MenuModule.message
      i += 1
      @input_code = false
    end
  end

  def input(attempts)
    until @input_code
      menu_process(attempts, @hints_total - @hints_used)
      guess = gets.chomp

      return false if guess == 'exit'

      if guess == 'hint'
        if (@hints_total - @hints_used).zero?
          puts 'No hints'.red
        else
          @hints_used += 1
          puts hint(@code)
        end
        MenuModule.message
        next
      end

      set_values(validation_guess(guess), guess, 'guess')
    end
  end
end
