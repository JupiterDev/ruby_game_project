class Card
  attr_accessor :card_title, :card_suit, :card_worth

  TITLES = %w[2 3 4 5 6 7 8 9 10 J Q K A]
	SUITS = %w[♠ ♥ ♣ ♦]

  def initialize(title, suit)
    @card_title = title
    @card_suit = suit
    validate!
    @card_worth = 0
    count_worth(title)
  end

  def validate!
    raise "Невозможно создать карту." unless TITLES.include?(@card_title) && SUITS.include?(@card_suit)
  end

  def count_worth(title)
    if %w[2 3 4 5 6 7 8 9 10].include? title
      @card_worth = title.to_i
    elsif %w[J Q K].include? title
      @card_worth = 10
    elsif title == "A"
      @card_worth = 11
    end
  end

end
