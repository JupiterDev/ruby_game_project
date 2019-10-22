require_relative 'participant'

class Dealer < Participant
  def take_a_card?
    @hand.hand_worth < 16 ? true : false
  end
end
