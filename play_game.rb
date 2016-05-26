require 'pry'
require './card'
require './deck'
require './hand'
require './player'
require './dealer'

def welcome_message
  menu_1 = [
    "W","l","o","e","t"," ","l","c","j","c","!"
  ]
  menu_2 = [
    "e","c","m"," ","o","B","a","k","a","k"
  ]
  menu = []
  system "clear"
  i = 0
  menu_1.each do |m1|
    menu.push m1.red.bold
      if i < (menu_1.length - 1)
        menu.push menu_2[i].light_white.bold
        i += 1
      end
  end
  puts menu.join
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

def quit?
  system "clear"
  welcome_message
  puts "Menu"
  puts "1) Play a hand"
  puts "2) Quit"
  print ">"
  gets.chomp.to_i != 1
end

def win_lose_message player, dealer
  if player.hand.busted?
    puts "You bust, Dealer Wins!"
  elsif dealer.hand.busted?
    puts "Dealer busts, You Win!".bold.red.blink
  elsif dealer.hand.blackjack?
    puts "Dealer has blackjack, Dealer Wins!"
  elsif player.hand.blackjack? && !dealer.hand.blackjack?
    puts "You Win!".bold.red.blink
  elsif player.hand.beats?(dealer.hand)
    puts "You Win!".bold.red.blink
  else
    puts "Dealer Wins!"
  end
  puts
  puts "Press [enter] to continue"
  gets
end

player = Player.new
dealer = Dealer.new

until quit?
  dealer.deal_hand_to(player)
  dealer.deal_hand_to(dealer)
  display_table_showing player, dealer
  if player.hand.blackjack?
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
      break if player.hand.busted?
    end
  end

  unless dealer.hand.blackjack? || player.hand.busted?
    display_table_full player, dealer
    while dealer.hit?
      dealer.hit(dealer)
      display_table_full player, dealer
      break if dealer.hand.busted?
    end
  end

  display_table_final player, dealer
  win_lose_message player, dealer
end
