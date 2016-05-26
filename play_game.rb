require 'pry'
require './card'
require './deck'
require './hand'
require './player'
require './dealer'

def display_table_starting player, dealer
  system "clear"
  puts "Welcome to Blackjack!"
  puts
  puts "Dealer"
  puts dealer.hand.showing
  puts
  puts
  puts "Your cards"
  puts player.hand.to_s + "              value: #{player.hand.value}"
  puts
end

def display_table_showing player, dealer
  system "clear"
  puts
  puts "Dealer"
  puts dealer.hand.showing
  puts
  puts
  puts
  puts "Your cards"
  puts player.hand.to_s + "              value: #{player.hand.value}"
  puts
end

def display_table_full player, dealer
  system "clear"
  puts
  puts "Dealer"
  puts dealer.hand.to_s + "              value: #{dealer.hand.value}"
  puts
  puts
  puts "Your cards"
  puts player.hand.to_s + "              value: #{player.hand.value}"
  puts
  puts "Press [enter] to continue"
  gets
end

def display_table_final player, dealer
  system "clear"
  puts "Final hands"
  puts
  puts "Dealer"
  puts dealer.hand.to_s + "              value: #{dealer.hand.value}"
  puts
  puts
  puts "Your cards"
  puts player.hand.to_s + "              value: #{player.hand.value}"
  puts
end

player = Player.new
dealer = Dealer.new

dealer.deal_hand_to(player)
dealer.deal_hand_to(dealer)

display_table_starting player, dealer
if player.hand.blackjack?
  player_blackjack = true
  puts "You got Blackjack!"
  puts
  puts "Lets see what the dealer has"
  puts
  puts "Press [enter] to continue"
  gets
else
  while player.hit?
    dealer.hit(player)
    display_table_showing player, dealer
    if player.hand.busted?
      puts "You bust, Dealer Wins!"
      exit
    end
  end
end
if dealer.hand.blackjack?
  dealer_blackjack = true
  display_table_full player, dealer
else
  while dealer.hit?
    dealer.hit(dealer)
    display_table_full player, dealer
    if dealer.hand.busted?
      puts "Dealer busts, You Wins!"
      exit
    end
  end
end

display_table_final player, dealer
if dealer_blackjack
  puts "Dealer Wins!"
elsif player_blackjack && !dealer_blackjack
  puts "You Win!"
elsif player.hand.beats?(dealer.hand)
  puts "You Win!"
else
  puts "Dealer Wins!"
end
