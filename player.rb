require './hand'

class Player

  attr_reader :wallet, :hand

  def initialize wallet = 0
    @wallet = wallet
    hand_new
  end

  def add_to_hand card
    @hand.add(card)
  end

  def wins ammount
    @wallet += ammount
  end

  def broke?
    wallet == 0
  end

  def hand_new
    @hand = Hand.new
  end

end
