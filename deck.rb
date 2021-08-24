class Deck
  attr_reader :deck
  CARD = %w[2 3 4 5 6 7 8 9 10 В Д К Т].freeze
  SUITS = ['♠', '♣', '♥', '♦'].freeze
  SYMBOL_CARD = { "В" => 2, "Д" => 3, "К" => 4, "Т" => 11 }

  def initialize
    @deck = []
    create_deck
  end

  def start
    [hand_deck, hand_deck]
  end

  def hand_deck
    cards = deck.sample
    deck.delete(cards)
  end

  private

  def create_deck
    CARD.map do |card|
      SUITS.map { |c| @deck << "#{card}#{c}" }
    end
  end

end
