
def get_name
  input_ok = false
  until input_ok
    s = gets.chomp
    if s.strip.length > 0
      input_ok = true
    else
      puts "\> Please enter your name to continue..."
    end
  end
  s
end

def ask_hit_or_stay
  puts "\> What do you want to do?"
  puts "\> h) Hit  or  s) Stay"
  input_ok = false
  until input_ok
    s = gets.chomp
    if ['h','s'].include?(s.downcase.strip)
      input_ok = true
    else
      puts "\> Please enter either 'h' or 's' to continue..."
    end
  end
  puts "\> You chose to #{s=='h' ? 'Hit' : 'Stay'}\n\n"
  s
end

def calculate_total(arr = [])
  total = 0
  ace_count = 0
  arr.each do |card|
    if card[1].to_i.to_s == card[1]
      total += card[1].to_i
    elsif ['J','Q','K'].include?(card[1])
      total += 10
    else # 'A'
      total += 11
      ace_count += 1
    end
  end
  until ace_count == 0 || total <= 21
    total -= 10
    ace_count -= 1
  end
  total
end

def print_player_cards(arr,total,name)
  puts "  Cards in #{name}'s' hand: "
  arr.each {|card| print "  [#{card[0]} #{card[1]}]" }
  puts "  Total: #{total}\n\n"
end

def deck
  ["Spade","Heart","Diamond","Club"].product(['A','2','3','4','5','6','7','8','9','10','J','Q','K'])
end

def ask_to_continue
  puts "\> Do you want to start another round?"
  puts "\> Type 'y' to continue, or hit [Enter] to end the game"
  s = gets.chomp
  s.downcase.strip == 'y' ? true : false
end

puts "\> What's your name"

player_name = get_name

puts "\> Hello, #{player_name}\n\n"

continue_to_play = true
game_count = 1
curr_deck = deck().shuffle

while continue_to_play

  puts "\> Game started...Round #{game_count}\n\n"

  curr_deck = deck().shuffle if curr_deck.length < 4

  player_hand = [curr_deck.pop, curr_deck.pop]
  dealer_hand = [curr_deck.pop, curr_deck.pop]

  game_over = false
  player_busted = false
  player_stay = false
  dealer_busted = false
  dealer_stay = false

  until game_over

    player_total = calculate_total(player_hand)
    dealer_total = calculate_total(dealer_hand)

    print_player_cards(player_hand, player_total, player_name)
    print_player_cards(dealer_hand, dealer_total, "Dealer")

    if player_total == 21
      puts "\> BlackJack! You win!\n\n"
      game_over = true
      break
    end

    unless player_stay == true
      player_action = ask_hit_or_stay
    else
      puts "\> You had chosen to stay. Hit [Enter] to continue..."
      gets
    end
    player_stay = true if player_action == 's'

    unless player_stay
      curr_deck = deck().shuffle if curr_deck.length == 0
      new_card = curr_deck.pop
      player_hand << new_card
      puts "\> You get a [#{new_card[0]} #{new_card[1]}]\n\n"
      player_total = calculate_total(player_hand)

      if player_total == 21
        puts "\> BlackJack! You win!\n\n"
        game_over = true
        break
      elsif player_total > 21
        puts "\> Busted! You lose!\n\n"
        game_over = true
        break
      end
    end

    dealer_stay = dealer_total >= 17
    unless dealer_stay
      curr_deck = deck().shuffle if curr_deck.length == 0
      dealer_hand << curr_deck.pop
      puts "\> Dealer chose to hit\n\n"
    else
      puts "\> Dealer chose stay\n\n"
    end

    dealer_total = calculate_total(dealer_hand)

    if dealer_total > 21
      puts "\> Dealer busted! You win!\n\n"
      game_over = true
    else
      if player_stay && dealer_stay
        if player_total > dealer_total
          puts "\> You win!\n\n"
        elsif dealer_total > player_total
          puts "\> You lose!\n\n"
        else
          puts "\> It's a tie.\n\n"
        end
        game_over = true
      end
    end

    puts "\n"
  end

  print_player_cards(player_hand, player_total, player_name)
  print_player_cards(dealer_hand, dealer_total, "Dealer")

  continue_to_play = ask_to_continue
  game_count += 1

end