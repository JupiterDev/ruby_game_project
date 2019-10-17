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
    ask_name                    # запрос имени пользователя
    set_user_name               # запись имени
    greeting(@player.name)      # приветствие

    give_cards(2, @player)      # отдаем пользователю 2 карты
    show_user_his_hand          # вывести на экран "руку" пользователя

    give_cards(2, @dealer)      # отдаем дилеру 2 карты
    show_dealer_hand(true) # вывести на экран руку дилера
  end

  def set_user_name
    @player.name = gets.chomp
  end

  def give_cards(number, object)
    cards = []
    number.times { cards << @table.take_a_card }
    object.hand.add_cards(cards)
  end

  def show_user_his_hand
    user_hand
    puts "#{@player.hand.cards[0].card_title}#{@player.hand.cards[0].card_suit} | #{@player.hand.cards[1].card_title}#{@player.hand.cards[1].card_suit}"
  end

  def show_dealer_hand(hidden)
    dealer_hand
    if hidden
      hidden_hand = []
      @dealer.hand.cards.length.times {hidden_hand << "**"}
      puts hidden_hand.join(" | ")
    else
    end
  end
end
