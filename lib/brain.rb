
class Brain
  def initialize(max_digit=5, max_length=4)
    @max_digit = max_digit
    @max_length = max_length
  end

  def create_code
  end

  def guess_code(history)
  end

  def code_valid?(code)
    # match?(/\A-?\d+\Z/) checks if string is integer
    code.length == @max_length and code.split('').all? { |digit| digit.match?(/\A-?\d+\Z/) and digit.to_i.between?(0, @max_digit) }
  end

  def win_message
  end
end


class Human < Brain
  def create_code
    print "Enter a #{@max_length} digit code using numbers #{0}..#{@max_digit}: "
    input_code
  end

  def guess_code(history)
    print "  Guess code: "
    input_code
  end

  def win_message
    'You wins! :D'
  end

  private

  def input_code
    input = gets.chomp
    until code_valid?(input)
      print "  Invalid code. Code must be #{@max_length} digits using numbers 0..#{@max_digit}. Please try again: "
      input = gets.chomp
    end
    input
  end
end


class Computer < Brain
  def initialize(max_digit=5, max_length=4)
    super
    @possible_guesses = []
  end

  def create_code
    code = ''
    @max_length.times {
      code += rand(@max_digit + 1).to_s
    }
    code
  end

  # Starting with all possible code combinations, the solution
  # gets narrowed down by looping through every possible combination.
  # If a combination does not produce the same feedback as the last guess, discard it.
  def guess_code(history)
    if @possible_guesses.empty?
      @possible_guesses = create_possible_guesses
    end
    
    last_guess = history[:guesses].last
    last_feedback = history[:feedback].last

    unless last_guess.nil?
      @possible_guesses.filter! do |possible|
        # Convert back to base max_digit+1, and pad with 0s.
        p = possible.to_s(@max_digit + 1).rjust(@max_length, '0')
        Mastermind::provide_feedback(last_guess, p) == last_feedback
      end
    end

    # Choose a random possible guess and convert it to the right base with padded 0s.
    code = @possible_guesses.sample.to_s(@max_digit + 1).rjust(@max_length, '0')

    print "  Guess code: "
    puts code
    code
  end

  def win_message
    'You loses... :('
  end

  private

  # The possible codes are just a base max_digit+1 number system,
  # so to get them all we can just convert it to base 10 and loop.
  # Later we convert them back. Stored as integers to save memory.
  def create_possible_guesses
    max_code = ''
    @max_length.times {
      max_code += @max_digit.to_s
    }
    max_b10 = max_code.to_i(@max_digit + 1)  # Convert from base max_digit+1 to base 10
    @possible_guesses = (0..max_b10).to_a
  end
end
