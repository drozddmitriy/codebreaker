module MenuModule
  def message
    puts I18n.t(:continue)
    gets
    system 'clear'
  end

  def main_menu
    puts I18n.t(:main_menu)
  end

  def menu_choose_difficulty
    system 'clear'
    puts I18n.t(:menu_choose_difficult)
  end

  def menu_process(attempts, hints)
    system 'clear'
    puts I18n.t(:menu_process, attempts: attempts, hints: hints)
  end

  def statistic(array)
    puts I18n.t(:statistic)
    rating = 1

    array.each do |e|
      puts "|#{rating}\t|#{e[:name]}\t|#{e[:difficulty]}\t\t|#{e[:attempts]}\t\t|#{e[:try]}\t\t|#{e[:hints_total]}\t\t|#{e[:hints_used]}\t\t|"
      rating += 1
    end
    message
  end

  def rules
    puts I18n.t(:rules)
    message
  end

  def error(name)
    puts I18n.t(:error, name: name)
    message
  end

  def menu_win(code)
    puts I18n.t(:menu_win, code: code)
  end

  def menu_lose(code)
    puts I18n.t(:menu_lose, code: code)
    message
  end

  def show_result(result)
    puts I18n.t(:show_result, result: result)
    message
  end
end
