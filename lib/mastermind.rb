require_relative 'brain'

class Mastermind
  def self.play(codemaster, codebreaker, rounds=12, max_digit=5, max_length=4)
    history = {guesses: [], feedback: []}

    guess = ''
    code = codemaster.create_code
    puts

    rounds.times do |round|
      puts "Round #{round + 1}:"
      guess = codebreaker.guess_code(history)
      feedback = provide_feedback(guess, code)
      display_feedback feedback
      history[:guesses].push(guess)
      history[:feedback].push(feedback)
      puts
      break if guess == code
    end

    if guess == code
      puts codebreaker.win_message
    else
      puts "The code was #{code}"
      puts codemaster.win_message
    end
  end

  def self.provide_feedback(guess, answer)
    # Map to keep track of which digits have been guessed, otherwise partial guesses can double up
    digits_map = answer.split('').reduce(Hash.new(0)) do |digits_map, digit|
      digits_map[digit] += 1
      digits_map
    end
  
    feedback = {exact: 0, partial: 0}
    
    # Need to look through exact matches before partial matches,
    # otherwise a partial match may trigger for an exact match.
    guess.split("").each_with_index do |g, i|
      if answer[i] == g
        feedback[:exact] += 1
        digits_map[g] -= 1
      end
    end
    guess.split("").each_with_index do |g, i|
      if not answer[i] == g and digits_map.has_key? g and digits_map[g] > 0
        feedback[:partial] += 1
        digits_map[g] -= 1
      end
    end
    feedback
  end

  def self.display_feedback(feedback)
    puts "  Exact matches: #{feedback[:exact]}"
    puts "  Partial matches: #{feedback[:partial]}"
  end
end
