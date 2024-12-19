
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
    code.length == @max_length && code.split('').all? { |digit| Integer(digit) rescue nil and digit.to_i.between?(0, @max_digit) }
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
  def create_code
    code = ''
    @max_length.times {
      code += rand(@max_digit + 1).to_s
    }
    code
  end

  def guess_code(history)
    print "  Guess code: "

    code = create_code
    puts code
    code
  end

  def win_message
    'You loses... :('
  end
end
