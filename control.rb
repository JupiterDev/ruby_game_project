require_relative 'bank'
require_relative 'player'
require_relative 'dealer'
require_relative 'table'

class Control

  def initialize(interface)
    @interface = interface
    @player = Player.new
    @dealer = Dealer.new
    @table = Table.new
  end

  def begin
    show_name_question                     # запрос имени пользователя
    get_user_name                          # получение и запись имени
    @interface.greeting(@player.name)      # приветствие

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

  def show_name_question
    @interface.ask_name
  end

  def get_user_name
    @player.name = @interface.get_answer
  end

  def give_cards(number, object)
    cards = []
    number.times { cards << @table.take_a_card }
    object.hand.add_cards(cards)
  end

  def show_user_his_hand
    @interface.user_hand_message
    cards = []
    @player.hand.cards.each do |card|
      cards << "#{card.card_title}#{card.card_suit}"
    end
    @interface.output(cards.join(" | "))
  end

  def show_user_points
    @interface.user_points_message
    @interface.output(@player.hand.hand_worth)
  end

  def show_dealer_hand(hidden)
    @interface.dealer_hand_message
    if hidden
      hidden_hand = []
      @dealer.hand.cards.length.times {hidden_hand << "**"}
      @interface.output(hidden_hand.join(" | "))
    else
      cards = []
      @dealer.hand.cards.each do |card|
        cards << "#{card.card_title}#{card.card_suit}"
      end
      @interface.output(cards.join(" | "))
    end
  end

  def show_dealer_points
    @interface.dealer_points_message
    @interface.output(@dealer.hand.hand_worth)
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
    @interface.borderline
    @interface.show_action_selection_menu
    action = @interface.get_answer.to_i
    case action
    when 1
      @interface.player_skip_the_action_message
    when 2
      @interface.player_take_a_card_message
      add_card(@player)
      show_user_his_hand
      show_user_points
    when 3
      show_cards
    else
      @interface.wrong_input_message
    end
    @interface.borderline
  end

  def add_card(object)
    object.hand.add_cards(@table.take_a_card)
  end

  def show_cards
    open_cards = true
    choose_a_winner
  end

  def dealer_action
    if @dealer.take_a_card?
      @interface.dealer_take_a_card_message
      add_card(@dealer)
    else
      @interface.dealer_skip_the_action_message
    end
    show_dealer_hand(true)
  end

  def choose_a_winner
    @interface.borderline
    show_user_his_hand
    show_user_points
    show_dealer_hand(false)
    show_dealer_points
    if @player.hand.hand_worth > 21 || @dealer.hand.hand_worth > @player.hand.hand_worth && @dealer.hand.hand_worth < 22
      @interface.dealer_win_message
      distribute_bets(@dealer)
    elsif @player.hand.hand_worth > @dealer.hand.hand_worth || @dealer.hand.hand_worth > @player.hand.hand_worth && @dealer.hand.hand_worth > 21
      @interface.player_win_message
      distribute_bets(@user)
    elsif @player.hand.hand_worth == @dealer.hand.hand_worth
      @interface.tie
      distribute_bets
    end
    @interface.show_user_bank(@player.bank.money)
    @interface.show_dealer_bank(@dealer.bank.money)
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

  def restart
    @interface.borderline
    @interface.show_restart_game_menu
    answer = @interface.get_answer.to_i
    if answer == 1
      start
    elsif answer == 2
      abort @interface.end_game_message
    else
      @interface.wrong_input_message
    end
  end
end
