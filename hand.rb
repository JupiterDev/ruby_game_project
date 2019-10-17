class Hand
  attr_reader :cards

  def initialize
    @cards = []
  end

  def add_cards(cards)
    cards.each { |card| @cards << card }
  end
end
