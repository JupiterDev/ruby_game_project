require_relative 'bank'
require_relative 'hand'

class Player
  attr_accessor :name, :hand

  def initialize
    @name = ""
    @bank = Bank.new
    @hand = Hand.new
  end

end
