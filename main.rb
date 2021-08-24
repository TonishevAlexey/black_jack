require_relative 'game'

class Main
  g = Game.new
  loop do
    g.start_game
    loop do
      g.round
      break if g.stop
    end
    puts "#{g.state}"
    puts  g.bank
    puts "Хотите сыграть еще?\n1=да,0=нет"
    break if gets.chomp.to_i == 0 || g.bank?
  end
end

Main.new