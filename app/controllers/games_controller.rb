require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    abc_array = ('A'..'Z').to_a
    @letters = abc_array.reduce([]) { |acc| acc << abc_array.sample }.slice(0, 10)
  end

  def score
    # @put_in_view = is_english?(params[:word])

    @result = 'Congrats! - The word is valid according to the grid and is
     an English word'
    if !english?(params[:word])
      @result = "The word may be valid according to the grid,
       but is not a valid English word"
    elsif !word_check?(params[:word], params[:letters])
      @result = "The word can't be built out of the original grid"
    end
  end

  def english?(word)
    url = "https://wagon-dictionary.herokuapp.com/#{word}"
    serialized_resp = URI.open(url).read
    JSON.parse(serialized_resp)['found']
  end

  def word_check?(attempt, grid)
    attempt_to_array = attempt.downcase.split('')
    grid_down = grid.downcase.split(' ')
    return false if attempt.chars.all? do |letter|
      attempt.count(letter) <= grid.count(letter)
    end

    attempt_to_array.all? do |x|
      attempt_to_array.count(x) == grid_down.count(x)
    end
  end
end
