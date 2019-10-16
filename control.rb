require_relative 'messages'
require_relative 'bank'
require_relative 'player'
require_relative 'dealer'

class Control
  include Messages   # вынес все puts в отдельный модуль

  def initialize
    @player = Player.new
    @dealer = Dealer.new
  end

  def start
    greeting
    ask_name
    set_user_name
    puts @player.name
  end

  def set_user_name
    @player.name = gets.chomp
  end

end
