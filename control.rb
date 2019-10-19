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

  def begin
    ask_name                    # запрос имени пользователя
    set_user_name               # запись имени
    greeting(@player.name)      # приветствие

    start
  end

  def start
    reset_data

    give_cards(2, @player)      # отдаем пользователю 2 карты
    show_user_his_hand          # вывести на экран "руку" пользователя
    show_user_points            # вывести очки пользователя

    give_cards(2, @dealer)      # отдаем дилеру 2 карты
    show_dealer_hand(true)      # вывести на экран руку дилера

    make_bets                   # игрок и дилер делают ставки

    make_actions                # выполняются ходы

    choose_a_winner             # выбирается победитель

  end

  def reset_data
    @player.reset_hand          # обнуляем карты в руке
    @dealer.reset_hand          # обнуляем карты в руке
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
    end
  end

  def show_dealer_points
    dealer_points
    puts @dealer.hand.hand_worth
  end

  def make_bets
    @player.bank.make_a_bet
    @dealer.bank.make_a_bet

    collect_money
  end

  def collect_money
    money = @player.bank.default_bet + @dealer.bank.default_bet
    @table.money_buffer = money
  end

  def make_actions
    open_cards = false

    loop do
      player_action
      dealer_action
      break if @player.hand.cards.length == 3 && @dealer.hand.cards.length == 3 || open_cards
    end
  end

  def player_action
    border
    action_selection
    action = gets.chomp.to_i
    case action
    when 1
      skip_a_move
    when 2
      player_take_a_card
      add_card(@player)
      show_user_his_hand
      show_user_points
    when 3
      show_cards
    else
      wrong_input
    end
    border
  end

  def skip_a_move
    return
  end

  def add_card(object)
    object.hand.add_cards(@table.take_a_card)
  end

  def show_cards
    open_cards = true
    choose_a_winner
  end

  def dealer_action
    if @dealer.hand.hand_worth < 16
      dealer_take_a_card
      add_card(@dealer)
    else
      dealer_skiped_the_action
    end
    show_dealer_hand(true)
  end

  def choose_a_winner
    show_user_his_hand
    show_user_points
    show_dealer_hand(false)
    show_dealer_points
    if @player.hand.hand_worth > 21 || @dealer.hand.hand_worth > @player.hand.hand_worth && @dealer.hand.hand_worth < 22
      dealer_win
      distribute_bets(@dealer)
    elsif @player.hand.hand_worth > @dealer.hand.hand_worth || @dealer.hand.hand_worth > @player.hand.hand_worth && @dealer.hand.hand_worth > 21
      player_win
      distribute_bets(@user)
    elsif @player.hand.hand_worth == @dealer.hand.hand_worth
      tie
      distribute_bets
    end
    show_user_bank
    show_dealer_bank
    restart
  end

  def distribute_bets(winner = "tie")
    if winner == @user
      @player.bank.money += @table.money_buffer
      @table.money_buffer = 0
    elsif winner == @dealer
      @dealer.bank.money += @table.money_buffer
      @table.money_buffer = 0
    else
      @player.bank.money += @table.money_buffer / 2
      @dealer.bank.money += @table.money_buffer / 2
      @table.money_buffer = 0
    end
  end

  def show_user_bank
    user_bank(@player.bank.money)
  end

  def show_dealer_bank
    dealer_bank(@dealer.bank.money)
  end

  def restart
    border
    restart_game
    answer = gets.chomp.to_i
    if answer == 1
      start
    elsif answer == 2
      abort end_game
    else
      wrong_input
    end
  end
end
