class Hand
  attr_reader :cards, :hand_worth
  attr_accessor :cards

  def initialize
    @cards = []
    @hand_worth = 0
  end

  def add_cards(cards)
    cards = [] << cards if cards.instance_of? Card
    cards.each { |card| @cards << card }
    count_worth
  end

  def count_worth
    @hand_worth = 0
    @cards.each do |card|
      @hand_worth += card.card_worth
    end
    check_worth
  end

  def check_worth
    puts "цена руки:"
    puts @hand_worth
    if @hand_worth > 21 && @cards.any? {|card| card.card_title == "A" && card.card_worth == 11 }
      ace_index = @cards.find_index{ |card| card.card_worth == 11 }
      @cards[ace_index].card_worth = 1
      @hand_worth -= 10
    end
  end
end
