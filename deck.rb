require_relative 'card'

class Deck
	attr_accessor :card_set

	CARD_TITLES = %w[2 3 4 5 6 7 8 9 10 J Q K A]
	CARD_SUITS = %w[♠ ♥ ♣ ♦]
	
	def initialize
		@card_set = []
		add_cards_to_set
	end

	def add_cards_to_set
		CARD_TITLES.each do |title|
			CARD_SUITS.each do |suit|
				@card_set << Card.new(title, suit)
			end
		end
	end

	def take_a_card
		@card_set.delete(@card_set.sample)
	end
end
