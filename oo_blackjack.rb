


module Blackjack
  def calculate_total

  end

  def busted? (v)
    v > 21
  end

  def compute_result

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
    @cards.pop
  end

  def shuffle!
    @cards.shuffle!
  end

end

class Participant
  include Blackjack
  attr_accessor :name, :cards

  def initialize ; end

  def show_cards

  end

end

class Dealer < Participant
  def choose_action

  end

end


class Player < Participant
  def choose_action

  end

end

class CardGame
  include Blackjack
  attr_accessor :num_players, :players, :deck, :round_count

  def ask_name

  end

  def round_start

  end

end


d = Deck.new
60.times {puts d.deal }
