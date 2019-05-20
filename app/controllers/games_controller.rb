require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    abc_array = ('A'..'Z').to_a
    @letters = abc_array.reduce([]) { |acc| acc << abc_array.sample }.slice(0, 10)
  end

  def score
    # @put_in_view = is_english?(params[:word])

    @result = 'Well done!'
    if !english?(params[:word])
      @result = 'Not an English word'
    elsif !word_check?(params[:word], params[:letters])
      @result = 'Not in the grid'
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
