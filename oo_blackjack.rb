


module Blackjack
  BLACKJACK_NUMBER = 21
  DEALER_STOP_POINT = 17
  def calculate_total(arr)
  total = 0
  ace_count = 0
  arr.each do |card|
    break unless card.instance_of? Card
    if card.face_value.to_i.to_s == card.face_value
      total += card.face_value.to_i
    elsif ['J','Q','K'].include?(card.face_value)
      total += 10
    else # 'A'
      total += 11
      ace_count += 1
    end
  end
  until ace_count == 0 || total <= BLACKJACK_NUMBER
    total -= 10
    ace_count -= 1
  end
  total
  end

  def busted? (v)
    v > BLACKJACK_NUMBER
  end

  def compare_result

  end

end



class Card
  attr_accessor :suit, :face_value

  def initialize (s,v)
    @suit = s
    @face_value = v
  end

  def to_s
    "[ #{@suit} #{face_value} ]"
  end

end


class Deck
  attr_accessor :cards, :num_decks, :in_order

  def initialize(n=1, b=false)
    @cards = Array.new
    @num_decks = n
    @in_order = b
    n.times { @cards += one_deck }
    shuffle! unless b
    self
  end

  def one_deck
    cards = Array.new
    ["Spade","Heart","Diamond","Club"].each do |suit|
      ['A','2','3','4','5','6','7','8','9','10','J','Q','K'].each do |value|
        cards << Card.new(suit,value)
      end
    end
    cards
  end

  def deal
    initialize(@num_decks,@in_order) if @cards.empty?
    puts "Dealing..."
    @cards.pop
  end

  def shuffle!
    @cards.shuffle!
  end

end


class Participant
  include Blackjack
  attr_accessor :name, :cards

  def initialize(s)
    @name = s
    @cards = []
  end

  def show_hand
    puts "Cards in #{@name}'s hand:"
    ret = cards.map { |c| c.to_s}
    puts "#{ret.join(', ')} Total: #{total}"
  end

  def info
    "#{self.class}: #{@name}"
  end

  def total
    calculate_total(cards)
  end

end


class Dealer < Participant
  def hit?
    if calculate_total(@cards) < 17
      puts "Dealer chose to hit"
      true
    end
  end

end


class Player < Participant
  def hit?
    puts "\> What do you want to do?"
    puts "\> 1) Hit  or  2) Stay"
    input_ok = false
    until input_ok
      s = gets.chomp
      if ['1','2'].include?(s)
        puts "You chose to #{s=='1' ? 'Hit' : 'Stay'}\n\n"
        return s == '1'
      else
        puts "#{s}\> Please enter either '1' or '2' to continue..."
      end
    end
  end

end


class CardGame
  include Blackjack
  attr_accessor :players, :deck, :round_count

  def initialize
    @players = []
    @round_count = 0
    @deck = Deck.new

    players << Player.new(get_user_name)
    players << Dealer.new("Dealer")
  end

  def get_user_name
    puts "\> Hello! What's your name?"
    3.times do
      s = gets.chomp
      if s.strip.length > 0
        puts "Hi, #{s}"
        return s
      end
    end
    "Player"
  end

  def run
    @round_count += 1
    puts "******************************"
    puts "  Blackjack Game - Round #{round_count}"
    puts "******************************"
    players.each do |p|
      p.cards << deck.deal
      p.cards << deck.deal
      p.show_hand if p.instance_of? Player
      while p.hit? do
        p.cards << deck.deal
        p.show_hand if p.instance_of? Player
        # todo - check result
      end

      # todo - ask if continue

    end

  end

end

g = CardGame.new
g.run
puts g.players.inspect


# d = Deck.new
# c_arr = []
# 3.times { c_arr << d.deal }
# puts c_arr

# p = Player.new("test")
# puts p.calculate_total(c_arr)


