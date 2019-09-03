module Codebreaker
  class Console
    include MenuModule
    include DatabaseModule
    include StatisticModule
    YES = 'y'.freeze

    def run
      loop do
        @game = Game.new
        system 'clear'
        main_menu
        case gets.chomp
        when I18n.t(:start) then start
        when I18n.t(:rule) then rules
        when I18n.t(:stats) then statistic(sort_player(load))
        when I18n.t(:exit)
          puts I18n.t(:goodbye)
          break
        else
          puts I18n.t(:please_choose_command)
          show_message_continue
        end
      end
    end

    def start
      return unless registration

      return unless check_difficulty

      game_process
    end

    def registration
      loop do
        return true if @game.player

        system 'clear'
        puts I18n.t(:enter_you_name)
        name = gets.chomp
        return false if name == I18n.t(:exit)

        error(I18n.t(:name)) unless @game.name_player(name)
      end
    end

    def check_difficulty
      loop do
        menu_choose_difficulty(Game::DIFFICULTIES)

        case gets.chomp
        when I18n.t(:easy, scope: [:difficulty]) then return @game.difficulty_for_player(:easy)
        when I18n.t(:medium, scope: [:difficulty]) then return @game.difficulty_for_player(:medium)
        when I18n.t(:hell, scope: [:difficulty]) then return @game.difficulty_for_player(:hell)
        when I18n.t(:exit) then return false
        else
          puts I18n.t(:please_choose_difficult)
          show_message_continue
        end
      end
    end

    def input
      loop do
        break if @game.input_code

        menu_process(@game.diff_try, @game.diff_hints)
        guess = gets.chomp

        return false if guess == I18n.t(:exit)

        if guess == I18n.t(:hint)
          hint = @game.hint
          if hint
            puts hint
          else
            puts I18n.t(:no_hints)
          end
          show_message_continue
          next
        end

        error(I18n.t(:guess)) unless @game.guess_player(guess)
      end
    end

    def game_process
      @game.set_code

      loop do
        return if input == false

        show_result(@game.check)
        if @game.win?
          menu_win(@game.code)
          save(@game.to_hash) if gets.chomp == YES
          show_message_continue
          return
        end

        return menu_lose(@game.code) if @game.diff_try.zero?

        # show_result(@game.check)
        @game.reset_input_code
      end
    end
  end
end
