class Console
  include MenuModule
  include DatabaseModule

  def run
    loop do
      @game = Game.new
      system 'clear'
      main_menu
      case gets.chomp
      when I18n.t(:start)
        next if registration == false
        next if check_difficulty == false

        game_process
      when I18n.t(:rule) then rules
      when I18n.t(:stats) then statistic(sort_player(load))
      when I18n.t(:exit)
        puts I18n.t(:goodbye)
        break
      else
        puts I18n.t(:please_choose_command)
        message
      end
    end
  end

  def registration
    loop do
      break if @game.name

      system 'clear'
      puts I18n.t(:entery_name)
      name = gets.chomp
      return false if name == I18n.t(:exit)

      error(I18n.t(:name)) unless @game.def_name(name)
    end
  end

  def check_difficulty
    loop do
      menu_choose_difficulty

      case gets.chomp
      when I18n.t(:easy)
        @game.set_difficul(I18n.t(:easy), 15, 2)
        break
      when I18n.t(:medium)
        @game.set_difficul(I18n.t(:medium), 10)
        break
      when I18n.t(:hell)
        @game.set_difficul(I18n.t(:hell), 5)
        break
      when I18n.t(:exit)
        return false
      else
        puts I18n.t(:please_choose_difficul)
        message
      end
    end
  end

  def input(attempts)
    loop do
      break if @game.input_code

      menu_process(attempts, @game.diff_hints)
      guess = gets.chomp

      return false if guess == I18n.t(:exit)

      if guess == I18n.t(:hint)
        if @game.diff_hints.zero?
          puts I18n.t(:no_hints)
        else
          puts @game.hint
        end
        message
        next
      end

      error(I18n.t(:guess)) unless @game.def_guess(guess)
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
        message
        return
      end

      return menu_lose(@game.code) if @game.diff_try.zero?

      show_result(result)
      @game.reset_input_code
    end
  end
end
