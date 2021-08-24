require_relative 'deck'
require_relative 'user'

class Game
  attr_reader :user, :dealer, :deck
  attr_accessor :stop, :state

  def initialize
    @user = nil
    @dealer = User.new
    @deck = Deck.new
    @stop = false
    @state = nil
  end

  def start_game
    @stop = false
    @state = nil
    if user.nil?
      print "Введите свое имя: "
      name = gets.chomp
      @user = User.new(name)
    end
    user.cards = []
    dealer.cards = []
    start_carts
  end

  def round
    puts "Ваши карты:#{user.cards}"
    puts "Ваши очки:#{points(user.cards)}"
    puts "Пропустить введите 1" if dealer.cards.size < 3
    puts "Добавить карту введите 2" if user.cards.size < 3
    puts "Открыть карты введите 3"
    c = gets.chomp.to_i
    case c
    when 1
      dealer.cards << deck.hand_deck if points(dealer.cards) < 17
    when 2
      user.cards << deck.hand_deck
      dealer.cards << deck.hand_deck if points(dealer.cards) < 17 && dealer.cards.size < 3
    when 3
      puts "Ваши очки:#{points(user.cards)}"
      puts "Карты диллера :#{dealer.cards}"
      puts "Очки диллера:#{points(dealer.cards)}"
      stop_round
      state_game
    end
    if dealer.cards.size == 3 && user.cards.size == 3
      puts "Ваши очки:#{points(user.cards)}"
      puts "Карты диллера :#{dealer.cards}"
      puts "Очки диллера:#{points(dealer.cards)}"
      stop_round
      state_game
    end
  end

  def bank
    puts "Ваш банк:#{user.bank}"
    puts "Банк дилера:#{dealer.bank}"
  end

  def bank?
    true if user.bank == 0 || dealer.bank == 0
  end

  private

  def state_game
    if (points(dealer.cards) > points(user.cards) && points(dealer.cards) < 22) || (points(dealer.cards) < 22 && points(user.cards) > 21)
      user.bank = user.bank - 10
      dealer.bank = dealer.bank + 10
      self.state = "поражение"
    elsif (points(dealer.cards) < points(user.cards) && points(user.cards) < 22) || (points(dealer.cards) > 21 && points(user.cards) < 22)
      user.bank = user.bank + 10
      dealer.bank = dealer.bank - 10
      self.state = "победа"
    elsif (points(dealer.cards) == points(user.cards) && points(dealer.cards) < 22) || (points(dealer.cards) > 21 && points(user.cards) > 21)
      self.state = "ничья"
    end
  end

  def stop_round
    self.stop = true
  end

  def start_carts
    user.cards = deck.start
    dealer.cards = deck.start
  end

  def points(p)

    sum = p.inject(0) do |sum, x|
      if Deck::SYMBOL_CARD.include?(x[0])
        x = Deck::SYMBOL_CARD[x[0]]
        x = 1 if Deck::SYMBOL_CARD[x[0]] == 'Т' && sum + x > 21
      end
      sum + x.to_i
    end
    sum
  end
end
