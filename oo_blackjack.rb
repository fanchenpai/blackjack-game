


module BlackjackRule
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

  def blackjack? (v)
    v == BLACKJACK_NUMBER
  end

  def compare_result

  end

end



class Card
  attr_accessor :suit, :face_value, :hidden

  def initialize (s,v)
    @suit = s
    @face_value = v
    @hidden = false
  end

  def to_s
    @hidden ? "[** hidden **]" : "[ #{@suit} #{face_value} ]"
  end

  def show_card
    @hidden = false
  end

  def hide_card
    @hidden = true
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

  def deal_one
    initialize(@num_decks,@in_order) if @cards.empty?
    puts "Dealing..."
    @cards.pop
  end

  def shuffle!
    @cards.shuffle!.shuffle!
  end

end


class Participant
  include BlackjackRule
  attr_accessor :name, :cards

  def initialize(s)
    @name = s
    @cards = []
  end

  def add_card(card, hidden=false)
    hidden ? card.hide_card : card.show_card
    cards << card
    puts "#{name} gets a #{card}"
  end

  def show_hand
    puts "Cards in #{@name}'s hand:"
    ret = cards.map { |c| c.to_s}
    puts "#{ret.join(', ')}"
  end

  def show_total
    puts "Total: #{total}"
  end

  def info
    "#{self.class}: #{@name}"
  end

  def total
    calculate_total(cards)
  end

  def clear_hand
    @cards = []
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
        puts "#{s}\> Please enter either '1' or '2' to round_continue..."
      end
    end
  end

end


class BlackjackGame
  include BlackjackRule
  attr_accessor :player, :dealer, :deck, :round_count, :round_over

  def initialize
    @round_count = 1
    @round_over = false
    @deck = Deck.new

    @player = Player.new(get_user_name)
    @dealer = Dealer.new("Dealer")
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

  def continue_to_play?
    puts
    puts "\> Do you want to start another round?"
    puts "\> Type 'y' to continue, or hit [Enter] to end the game"
    s = gets.chomp
    s.downcase.strip == 'y' ? true : false
  end

  def clear_table
    player.clear_hand
    dealer.clear_hand
    @round_count += 1
    @round_over = false
  end

  def run
    game_header
    initial_dealing
    player_turn unless round_over
    dealer_turn unless round_over
    round_result
    if continue_to_play?
      clear_table
      run
    end
  end

  def game_header

    puts "******************************"
    puts "  Blackjack Game - Round #{round_count}"
    puts "******************************"
  end

  def initial_dealing
    player.add_card(deck.deal_one)
    player.add_card(deck.deal_one)
    dealer.add_card(deck.deal_one,true)
    dealer.add_card(deck.deal_one)
    puts ""
    player.show_hand
    player.show_total
    dealer.show_hand
    puts ""

  end

  def player_turn
    while round_continue? && player.hit? do
      player.add_card(deck.deal_one)
      player.show_hand
      player.show_total
    end
  end

  def dealer_turn
    while round_continue? && dealer.hit? do
      dealer.add_card(deck.deal_one)
    end
  end

  def round_continue?
    @round_over = busted?(player.total) || blackjack?(player.total) || busted?(dealer.total) || blackjack?(dealer.total)
    !round_over
  end

  def round_result
    if busted?(player.total)
      say_result "Busted. Sorry, you lose."
    elsif blackjack?(player.total)
      if blackjack?(dealer.total)
        say_result "It's a tie. Both the deal and you hit Blackjack!"
      else
        say_result "Blackjack! You win!"
      end
    else
      if busted?(dealer.total)
        say_result "Dealer busted. You win!"
      else
        if player.total > dealer.total
          say_result "You win!"
        elsif player.total < dealer.total
          say_result "You lose."
        else
          say_result "It's a tie."
        end
      end
    end
    dealer_flip
  end

  def say_result(s)
    puts "==> #{s}"
  end

  def dealer_flip
    dealer.cards[0].show_card
    dealer.show_hand
    dealer.show_total
  end

end

g = BlackjackGame.new
g.run

