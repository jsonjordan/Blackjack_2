class Card
  attr_reader :rank, :suit

  def initialize rank, suit
    @rank, @suit = rank, suit
  end

  def value
    case rank
    when :K, :Q, :J
      10
    when :A
      1
    else
      rank
    end
  end

  def to_s
    "#{rank}#{suit}"
  end
end

class Deck
  SUITS = [:S, :D, :H, :C]
  RANKS = 2.upto(10).to_a + [:J, :Q, :K, :A]

  attr_reader :cards, :drawn

  def initialize
    @cards, @drawn = [], []
    SUITS.each do |suite|
      RANKS.each do |rank|
        @cards.push Card.new(suite, rank)
      end
    end
    @cards.shuffle!
  end

  def draw
    card = @cards.pop
    @drawn.push card
    card
  end
end

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
    value == 21
  end

  def busted?
    value > 21
  end

  def to_s
    cards.map { |c| c.to_s }.join ", "
  end
end
