class Console
  include MenuModule
  include DatabaseModule

  def run
    loop do
      @game = Game.new
      system 'clear'
      main_menu
      case gets.chomp
      when 'start'
        next if registration == false
        next if check_difficulty == false
        game_process
      when 'rules'
        rules
      when 'stats'
        statistic(load)
      when 'exit'
        puts 'goodbye)))'.blue
        break
      else
        puts 'Error please choose one from listed commands'.red
        MenuModule.message
      end
    end
  end

  def registration
    until @game.name
      system 'clear'
      puts 'Entery you name!'.green
      name = gets.chomp
      return false if name == 'exit'

      error('name') unless @game.set_name(name)
    end
  end

  def check_difficulty
    until @game.attempts
      menu_choose_difficulty

      case gets.chomp
      when 'easy'
        @game.set_difficul('easy', 15, 2)
        break
      when 'medium'
        @game.set_difficul('medium', 10, 1)
        break
      when 'hell'
        @game.set_difficul('hell', 5, 1)
        break
      when 'exit'
        return false
      else
        puts 'Error please choose difficul'.red
        MenuModule.message
      end
    end
  end

  def input(attempts)
    until @game.input_code
      menu_process(attempts, @game.diff_hints)
      guess = gets.chomp

      return false if guess == 'exit'

      if guess == 'hint'
        puts @game.hint
        MenuModule.message
        next
      end

      error('guess') unless @game.set_guess(guess)
    end
  end

  def game_process
    @game.set_code

    loop do
      return if input(@game.diff_try) == false

      @game.add_try
      result = @game.check

      if result == true
        menu_win(@game.code)
        save(@game.to_hash) if gets.chomp == 'y'
        MenuModule.message
        return
      end

      return menu_lose(@game.code) if result == false || @game.diff_try.zero?

      show_result(result)
      @game.reset_input_code
    end
  end

end
