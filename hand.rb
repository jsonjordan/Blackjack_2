require 'pry'

class Hand
  attr_reader :cards

  def initialize
    @cards = []
  end

  def add *new_cards
    @cards += new_cards
  end

  def value
    base = cards.map { |c| c.value }.reduce(:+)
    if cards.any? { |c| c.rank == :A } && base <= 11
      base + 10
    else
      base
    end
  end

  def blackjack?
    (value == 21) && (cards.count == 2)
  end

  def busted?
    value > 21
  end

  def to_s
    cards.map { |c| c.to_s }.join ", "
  end

  def showing
    cards.first.to_s + " 🂠".light_white
  end

  def beats? other_hand
    if !busted? && !other_hand.busted?
      if value == other_hand.value
        false
      else
        value > other_hand.value
      end
    elsif busted? && !other_hand.busted?
      false
    elsif !busted? && other_hand.busted?
      true
    else
      false
    end
  end
end
