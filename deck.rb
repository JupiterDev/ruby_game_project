require_relative 'card'

class Deck
	attr_accessor :card_set
	
	def initialize
		@card_set = []
		add_cards_to_set
	end

	def add_cards_to_set
		Card::TITLES.each do |title|
			Card::SUITS.each do |suit|
				@card_set << Card.new(title, suit)
			end
		end
	end

	def take_a_card
		@card_set.delete(@card_set.sample)
	end
end
