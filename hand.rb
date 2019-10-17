class Hand
  attr_reader :cards, :hand_worth

  def initialize
    @cards = []
    @hand_worth = 0
  end

  def add_cards(cards)
    cards.each { |card| @cards << card }
    count_worth
  end

  def count_worth
    @cards.each { |card| @hand_worth += card.card_worth }
  end
end
