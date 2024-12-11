MAX_DIGIT = 5

CODE = '0123'

def input_guess
    input = gets.chomp
    until input_valid? input
        puts 'Invalid code. Please try again:'
        input = gets.chomp
    end
    input
end

def input_valid?(input)
    input.length == 4 && input.split('').all? { |digit| digit.to_i.between?(0, MAX_DIGIT) }
end

def guess_feedback(guess, code)
    feedback = {exact: 0, partial: 0}
    guess.each_with_index do |i, g|
        if code[i] == g
            feedback[:exact] += 1
        elsif code.include? g
            feedback[:partial] += 1
        end
    end
    feedback
end

guess = ''
12.times do |round|
    puts "Round #{round}:"
    guess = input_guess
    break if guess == CODE
end

if guess == CODE
    puts 'You wins!'
else
    puts 'You loses!'
end
