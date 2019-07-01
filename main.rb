require './dependency'

loop do
  system 'clear'
  game = Game.new
  game.menu_main
  choise = gets.chomp
  case choise
  when 'start'
    next if game.registration == false
    next if game.check_difficulty == false
    game.game_process
    # binding.pry
  when 'rules'
    game.rules
  when 'stats'
    game.statistic(game.data)
  when 'exit'
    puts 'goodbye)))'.blue
    break
  else
    puts 'Error please choose one from listed commands'.red
    puts 'Press entert to continue!'.green
    gets
  end
end
sleep 1
system 'clear'
