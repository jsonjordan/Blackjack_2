require 'pry'
require './card'
require './deck'
require './hand'
require './player'
require './dealer'

puts "Welcome to Blackjack!"
puts
puts "How much money do you have to wager?"
wallet = gets.chomp.to_i
player = Player.new(wallet)

dealer = Dealer.new

dealer.deal_hand_to(player)
dealer.deal_hand_to(dealer)

puts "Dealer"
puts dealer.hand.showing
puts
puts
puts "Your cards"
puts player.hand.to_s
