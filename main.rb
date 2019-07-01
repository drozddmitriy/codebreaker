require './dependency'

loop do
  game = Game.new
  obj = game.object
  game.menu_main
  choise = gets.chomp
  case choise
  when 'start'
    game.run
  when 'rules'
    game.rules
  when 'stats'
    game.statistic(obj)
  when 'exit'
    puts 'goodbye)))'.blue
    break
  else
    puts 'Error please choose one from listed commands'.red
    puts 'Press entert to continue!'.green
    gets
  end
  system 'clear'
end
sleep 1
system 'clear'
