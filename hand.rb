class Hand
  attr_reader :cards, :hand_worth

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
      if card.card_worth == 1 && @hand_worth < 11
        @hand_worth += 11
      elsif card.card_worth == 1 && @hand_worth >= 11
        @hand_worth += 1
      else
        @hand_worth += card.card_worth
      end
    end
  end
end
