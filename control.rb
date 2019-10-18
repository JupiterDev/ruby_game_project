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
    # puts @player.bank.money
    # puts @dealer.bank.money

    ask_name                    # запрос имени пользователя
    set_user_name               # запись имени
    greeting(@player.name)      # приветствие

    give_cards(2, @player)      # отдаем пользователю 2 карты
    show_user_his_hand          # вывести на экран "руку" пользователя
    show_user_points            # вывести очки пользователя

    give_cards(2, @dealer)      # отдаем дилеру 2 карты
    show_dealer_hand(true)      # вывести на экран руку дилера
    # show_dealer_points        # вывести очки дилера

    make_bets                   # игрок и дилер делают ставки

    make_actions                # выполняются ходы

    choose_a_winner             # выбирается победитель

    # puts @player.bank.money
    # puts @dealer.bank.money
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
    cards = []
    @player.hand.cards.each do |card|
      cards << "#{card.card_title}#{card.card_suit}"
    end
    puts cards.join(" | ")
    # puts "#{@player.hand.cards[0].card_title}#{@player.hand.cards[0].card_suit} | #{@player.hand.cards[1].card_title}#{@player.hand.cards[1].card_suit}"
  end

  def show_user_points
    user_points
    puts @player.hand.hand_worth
  end

  def show_dealer_hand(hidden)
    dealer_hand
    if hidden
      hidden_hand = []
      @dealer.hand.cards.length.times {hidden_hand << "**"}
      puts hidden_hand.join(" | ")
    else
      cards = []
      @dealer.hand.cards.each do |card|
        cards << "#{card.card_title}#{card.card_suit}"
      end
      puts cards.join(" | ")
      # puts "#{@dealer.hand.cards[0].card_title}#{@dealer.hand.cards[0].card_suit} | #{@dealer.hand.cards[1].card_title}#{@dealer.hand.cards[1].card_suit}"
    end
  end

  def show_dealer_points
    dealer_points
    puts @dealer.hand.hand_worth
  end

  def make_bets
    @player.bank.make_a_bet
    @dealer.bank.make_a_bet
  end

  def make_actions
    # until (@player.hand.cards.length == 3 && @dealer.hand.cards.length == 3) || open_cards do
    #   player_action
    #   dealer_action
    # end
    show_cards = false

    loop do
      player_action
      dealer_action
      break if @player.hand.cards.length == 3 && @dealer.hand.cards.length == 3
    end
  end

  def player_action
    action_selection
    action = gets.chomp.to_i
    case action
    when 1
      skip_a_move
    when 2
      add_card(@player)
    when 3
      show_cards
    else
      wrong_input
    end
  end

  # def check_cards_count
  #   break if @player.hand.cards.length == 3 && @dealer.hand.cards.length
  # end

  def skip_a_move
    return
  end

  def add_card(object)
    object.hand.add_cards(@table.take_a_card) if object.hand.cards.length < 3
    show_user_his_hand
    show_dealer_hand(true)
  end

  def show_cards
    # break true
    show_cards = true
  end

  def dealer_action
    # check_cards_count
    if @dealer.hand.hand_worth > 16
      return
    else
      dealer_take_a_card
      add_card(@dealer)
    end
    show_dealer_hand(true)
  end

  def choose_a_winner
    show_user_his_hand
    show_user_points
    show_dealer_hand(false)
    show_dealer_points
    if @player.hand.hand_worth > 21 || @dealer.hand.hand_worth > @player.hand.hand_worth
      dealer_win
    elsif @player.hand.hand_worth > @dealer.hand.hand_worth
      player_win
    else
      tie
    end
  end
end
