require_relative 'messages'
require_relative 'bank'
require_relative 'player'
require_relative 'dealer'
require_relative 'table'

class Control
  include Messages   # вынес все puts в отдельный модуль

  def initialize
    @player = Player.new
    @dealer = Dealer.new
    @table = Table.new
  end

  def start
    greeting                    # приветствие
    ask_name                    # запрос имени пользователя
    set_user_name               # запись имени

    give_cards(2, @player)       # отдаем пользователю 2 карты
    give_cards(2, @dealer)       # отдаем дилеру 2 карты

    puts @player.hand.cards
  end

  def set_user_name
    @player.name = gets.chomp
  end

  def give_cards(number, object)
    cards = []
    number.times { cards << @table.take_a_card }
    object.hand.add_cards(cards)
    # eval("%#{object}").hand.add_cards()
  end

end
