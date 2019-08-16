module Codebreaker
  module MenuModule
    def show_message_continue
      puts I18n.t(:continue)
      gets
      system 'clear'
    end

    def main_menu
      puts I18n.t(:main_menu)
    end

    def menu_choose_difficulty(difficulties)
      system 'clear'
      puts I18n.t(:menu_choose_difficult,
                  easy_attempts: difficulties[:easy][:attempts],
                  easy_hints: difficulties[:easy][:hints],
                  medium_attempts: difficulties[:medium][:attempts],
                  medium_hints: difficulties[:medium][:hints],
                  hell_attempts: difficulties[:hell][:attempts],
                  hell_hints: difficulties[:hell][:hints])
    end

    def menu_process(attempts, hints)
      system 'clear'
      puts I18n.t(:menu_process, attempts: attempts, hints: hints)
    end

    def statistic(array)
      puts I18n.t(:statistic)
      rating = 1

      array.each do |e|
        part2 = "|#{e[:try]}\t\t|#{e[:hints_total]}\t\t|#{e[:hints_used]}\t\t|"
        part1 = "|#{rating}\t|#{e[:name]}\t|#{e[:difficulty]}\t\t|#{e[:attempts]}\t\t"
        puts part1 + part2
        rating += 1
      end
      show_message_continue
    end

    def rules
      puts I18n.t(:rules)
      show_message_continue
    end

    def error(name)
      puts I18n.t(:error, name: name)
      show_message_continue
    end

    def menu_win(code)
      puts I18n.t(:menu_win, code: code)
    end

    def menu_lose(code)
      puts I18n.t(:menu_lose, code: code)
      show_message_continue
    end

    def show_result(result)
      puts I18n.t(:show_result, result: result)
      show_message_continue
    end
  end
end
