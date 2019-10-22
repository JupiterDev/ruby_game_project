require_relative 'participant'

class Player < Participant
  attr_accessor :name

  def initialize
    super
    @name = ""
  end

end
