
ROUNDS = 12
MAX_DIGIT = 5
MAX_LEN = 4

# Generates a MAX_LEN digit code.
# Allows trailing 0s and does not contain any digits over MAX_DIGIT
def generate_code
  code = ''
  MAX_LEN.times {
    code += rand(MAX_DIGIT + 1).to_s
  }
  # puts "Code: #{code}"
  code
end

def input_code
  input = gets.chomp
  until code_valid? input
    puts "Invalid code. Code must be #{MAX_LEN} digits in the range [#{0}, #{MAX_DIGIT}]. Please try again:"
    input = gets.chomp
  end
  input
end

def generate_guess
  generate_code
end

def code_valid?(code)
  code.length == MAX_LEN && code.split('').all? { |digit| digit.to_i.between?(0, MAX_DIGIT) }
end

def guess_feedback(guess, answer)
  # Map to keep track of which digits have been guessed, otherwise partial guesses can double up
  digits_map = answer.split('').reduce(Hash.new(0)) do |digits_map, digit|
    digits_map[digit] += 1
    digits_map
  end

  feedback = {exact: 0, partial: 0}
  
  guess.split("").each_with_index do |g, i|
    if answer[i] == g
      feedback[:exact] += 1
      digits_map[g] -= 1
    elsif digits_map.has_key? g and digits_map[g] > 0
      feedback[:partial] += 1
      digits_map[g] -= 1
    end
  end
  feedback
end

puts 'Choose 1 to be the Codemaster, or 2 to be the Codecracker'
choice = gets.chomp
until choice == '1' or choice == '2'
  puts 'Please pick either 1 or 2'
  choice = gets.chomp
end
player_cracker = choice == '2'

if player_cracker
    
else
  puts "Write a #{MAX_LEN} digit code with digits in the range [#{0}, #{MAX_DIGIT}]:"
end

code = player_cracker ? generate_code : input_code
guess = ''
ROUNDS.times do |round|
  puts "Round #{round + 1}:"
  guess = player_cracker ? input_code : generate_guess
  if !player_cracker
    puts guess
  end
  puts guess_feedback(guess, code)
  puts
  break if guess == code
end

if guess == code
  puts player_cracker ? 'You wins! :D' : 'You loses :('
else
  puts player_cracker ? 'You loses :(' : 'You wins! :D'
end
