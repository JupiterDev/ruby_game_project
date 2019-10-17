require_relative 'bank'
require_relative 'hand'

class Dealer
  attr_accessor :hand, :bank

  def initialize
    @bank = Bank.new
    @hand = Hand.new
  end
end
