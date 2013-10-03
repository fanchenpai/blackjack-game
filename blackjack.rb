def say(s) puts "\> #{s}" end

def get_name(err_msg)
  input_ok = false
  until input_ok
    s = gets.chomp
    if s.strip.length > 0
      input_ok = true
    else
      say err_msg
    end
  end
  s
end

def calculate_total(arr = [])
  total = 0
  ace_count = 0
  arr.each do |card|
    total += get_value(card[1])
    ace_count += 1 if card[1]=='A'
  end
  until ace_count == 0 || total <= 21
    total -= 10
    ace_count -= 1
  end

  total
end

def get_value(c)
  if c.to_i.to_s == c
    c.to_i
  elsif ['J','Q','K'].include?(c)
    10
  else
    11
  end
end

def print_cards(arr)
  arr.each {|card| puts "#{card[0]}\t#{card[1]}" }
end

def ask_hit_or_stay
  say "h) Hit  or  s) Stay?"
  input_ok = false
  until input_ok
    s = gets.chomp
    if ['h','s'].include?(s.downcase.strip)
      input_ok = true
    else
      say "Please enter either 'h' or 's' to continue..."
    end
  end
  say "You chose to #{s=='h' ? 'Hit' : 'Stay'}\n\n"
  s
end

def print_player_cards(arr,total,name)
  puts "====================="
  puts "Cards in #{name}'s' hand: "
  print_cards(arr)
  puts "Total: #{total}"
  puts "====================="
end

say "What's your name"

player_name = get_name "Please enter your name to continue..."

say "Hello, #{player_name}\n\n"

say "Game started...\n\n"

deck = ["Spade","Heart","Diamond","Club"].product(['A','2','3','4','5','6','7','8','9','10','J','Q','K'])
curr_deck = deck.shuffle.shuffle.shuffle


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

  if player_total == 21
    say "BlackJack! You win!\n\n"
    game_over = true
    break
  end

  unless player_stay == true
    player_action = ask_hit_or_stay
  else
    say "You had chosen to stay. Hit [Enter] to continue..."
    gets
  end
  player_stay = true if player_action == 's'

  unless player_stay
    new_card = curr_deck.pop
    player_hand << new_card
    say "You get a #{new_card[0]} #{new_card[1]}\n\n"
    player_total = calculate_total(player_hand)

    if player_total == 21
      say "BlackJack! You win!\n\n"
      game_over = true
      break
    elsif player_total > 21
      say "Busted! You lose!\n\n"
      game_over = true
      break
    end
  end

  dealer_stay = dealer_total >= 17
  unless dealer_stay
    dealer_hand << curr_deck.pop
    say "Dealer chose to hit\n\n"
  else
    say "Dealer chose stay\n\n"
  end

  dealer_total = calculate_total(dealer_hand)

  if dealer_total > 21
    say "Dealer busted! You win!\n\n"
    game_over = true
  else
    if player_stay && dealer_stay
      if player_total > dealer_total
        say "You win!\n\n"
      elsif dealer_total > player_total
        say "You lose!\n\n"
      else
        say "It's a tie.\n\n"
      end
      game_over = true
    end
  end

  puts "\n\n"
end

print_player_cards(player_hand, player_total, player_name)
print_player_cards(dealer_hand, dealer_total, "Dealer")

