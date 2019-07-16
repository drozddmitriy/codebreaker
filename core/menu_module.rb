module MenuModule
  def message
    puts 'Press entert to continue!'
    gets
    system 'clear'
  end

  def main_menu
    puts 'Welcome to game Codebraker!'
    puts '*************'
    puts 'start'
    puts 'rules'
    puts 'stats'
    puts 'exit'
    puts '*************'
    puts 'Please choose one from listed commands'
  end

  def menu_choose_difficulty
    system 'clear'
    puts 'choise difficulties'
    puts '******************************'
    puts 'easy - 15 attempts. 2 hints'
    puts 'medium - 10 attempts. 1 hint'
    puts 'hell - 5 attempts. 1 hint'
    puts 'exit'
    puts '******************************'
    puts 'Please choose difficul'
  end

  def menu_process(attempts, hints)
    system 'clear'
    puts 'Game process:'
    puts '******************************'
    puts "attempts - #{attempts}"
    puts '******************************'
    puts 'your choise'
    puts '******************************'
    puts "hint - #{hints}"
    puts 'exit'
    puts '******************************'
    puts 'Entery you guess!'
  end

  def statistic(array)
    puts "|Rating\t|Name\t|Difficulty\t|Attempts Total\t|Attempts Used\t|Hints Total\t|Hints Used\t|"
    rating = 1

    array.each do |e|
      puts "|#{rating}\t|#{e[:name]}\t|#{e[:difficulty]}\t\t|#{e[:attempts]}\t\t|#{e[:try]}\t\t|#{e[:hints_total]}\t\t|#{e[:hints_used]}\t\t|"
      rating += 1
    end
    message
  end

  def rules
    puts <<-FOO
    Game Rules

    $ Codebreaker is a logic game in which a code-breaker tries to break a secret code
    created by a code-maker. The codemaker, which will be played by the application we’re
    going to write, creates a secret code of four numbers between 1 and 6.

    $ The codebreaker gets some number of chances to break the code (depends on chosen
    difficulty). In each turn, the codebreaker makes a guess of 4 numbers. The codemaker
    then marks the guess with up to 4 signs - + or - or empty spaces.

    $ A + indicates an exact match: one of the numbers in the guess is the same as one of the
    numbers in the secret code and in the same position. For example:
    Secret number - 1234
    Input number - 6264
    Number of pluses - 2 (second and fourth position)

    $ A - indicates a number match: one of the numbers in the guess is the same as one of the
    numbers in the secret code but in a different position. For example:
    Secret number - 1234
    Input number - 6462
    Number of minuses - 2 (second and fourth position)

    $ An empty space indicates that there is not a current digit in a secret number.

    $ If codebreaker inputs the exact number as a secret number - codebreaker wins the
    game. If all attempts are spent - codebreaker loses.

    $ Codebreaker also has some number of hints(depends on chosen difficulty). If a user takes
    a hint - he receives back a separate digit of the secret code.
    FOO

    message
  end

  def error(name)
    puts "Error please enter valid #{name}"
    message
  end

  def menu_win(code)
    puts "Secret code: #{code}"
    puts 'You win)))!!!'
    puts 'Do you want to save the result? [y/n]'
  end

  def menu_lose(code)
    puts "Secret code: #{code}"
    puts 'You lose((('
    message
  end

  def show_result(result)
    print 'Result:'
    puts result
    message
  end
end
