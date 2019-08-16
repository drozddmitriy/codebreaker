module Codebreaker
  class Console
    include MenuModule
    include DatabaseModule
    include StatisticModule
    YES = 'y'.freeze
    DIFFICULTIES = {
      easy: {
        attempts: 15,
        hints: 2
      },
      medium: {
        attempts: 10,
        hints: 1
      },
      hell: {
        attempts: 5,
        hints: 1
      }
    }.freeze

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
      return if registration == false

      return if check_difficulty == false

      game_process
    end

    def registration
      loop do
        break if @game.player

        system 'clear'
        puts I18n.t(:entery_name)
        name = gets.chomp
        return false if name == I18n.t(:exit)

        error(I18n.t(:name)) unless @game.name_player(name)
      end
    end

    def check_difficulty
      loop do
        menu_choose_difficulty(DIFFICULTIES)

        case gets.chomp
        when I18n.t(:easy, scope: [:difficulty])
          @game.difficulty_player(I18n.t(:easy, scope: [:difficulty]), DIFFICULTIES[:easy][:attempts],
                                  DIFFICULTIES[:easy][:hints])
          break
        when I18n.t(:medium, scope: [:difficulty])
          @game.difficulty_player(I18n.t(:medium, scope: [:difficulty]), DIFFICULTIES[:medium][:attempts])
          break
        when I18n.t(:hell, scope: [:difficulty])
          @game.difficulty_player(I18n.t(:hell, scope: [:difficulty]), DIFFICULTIES[:hell][:attempts])
          break
        when I18n.t(:exit) then return false
        else
          puts I18n.t(:please_choose_difficul)
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
          if @game.diff_hints.zero?
            puts I18n.t(:no_hints)
          else
            puts @game.hint
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

        @game.add_try
        if @game.win?
          menu_win(@game.code)
          save(@game.to_hash) if gets.chomp == YES
          show_message_continue
          return
        end

        return menu_lose(@game.code) if @game.diff_try.zero?

        show_result(@game.check)
        @game.reset_input_code
      end
    end
  end
end
