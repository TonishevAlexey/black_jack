class User
  attr_accessor :bank, :cards
  attr_reader :name

  def initialize(name = "dealer")
    @name = name
    @bank = 100
    @cards = []
  end
end