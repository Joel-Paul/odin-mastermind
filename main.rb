
require_relative 'lib/mastermind'
require_relative 'lib/brain'

ROUNDS = 12
MAX_DIGIT = 5
MAX_LENGTH = 4

print 'Type 1 to be the Codemaster, or 2 to be the Codebreaker: '
choice = gets.chomp
until choice == '1' or choice == '2'
  print 'Please pick either 1 or 2: '
  choice = gets.chomp
end

codemaster = Human.new(MAX_DIGIT, MAX_LENGTH)
codebreaker = Computer.new(MAX_DIGIT, MAX_LENGTH)
if choice == '2'
  codemaster, codebreaker = codebreaker, codemaster
end

Mastermind::play(codemaster, codebreaker, ROUNDS, MAX_DIGIT, MAX_LENGTH)
