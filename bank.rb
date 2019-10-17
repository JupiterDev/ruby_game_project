class Bank
  attr_accessor :money

  DEFAULT_MONEY_AMOUNT = 100
  DEFAULT_BET = 10
  
  def initialize
    @money = DEFAULT_MONEY_AMOUNT
  end

  def make_a_bet
    @money -= DEFAULT_BET if @money >= DEFAULT_BET
  end

end
