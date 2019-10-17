require_relative 'deck'

class Table
  def initialize
    @deck = Deck.new
  end

  def take_a_card
    @deck.take_a_card
  end
end
