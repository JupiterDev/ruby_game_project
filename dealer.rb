require_relative 'bank'
require_relative 'hand'

class Dealer
  attr_accessor :hand

  def initialize
    @bank = Bank.new
    @hand = Hand.new
  end
end
