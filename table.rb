require_relative 'deck'

class Table

  attr_accessor :money_buffer
  attr_reader :deck

  def initialize
    @deck = Deck.new
    @money_buffer = 0
  end

  def take_a_card
    @deck = Deck.new if @deck.card_set.empty?
    @deck.take_a_card
  end

end
