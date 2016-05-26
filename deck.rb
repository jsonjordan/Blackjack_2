require 'colorize'

class Deck
  SUITS = ["♠".light_white, "♦".red, "♥".red, "♣".light_white]
  RANKS = 2.upto(10).to_a + [:J, :Q, :K, :A]

  attr_reader :cards, :drawn

  def initialize
    reshuffle
  end

  def draw
    card = @cards.pop
    @drawn.push card
    card
  end

  def reshuffle
    @cards, @drawn = [], []
    SUITS.each do |suit|
      RANKS.each do |rank|
        @cards.push Card.new(rank, suit)
      end
    end
    @cards.shuffle!
  end

end
