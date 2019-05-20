class GamesController < ApplicationController
  def new
    abc_array = ('A'..'Z').to_a
    @letters = abc_array.reduce([]) { |acc| acc << abc_array.sample }.slice(0, 10)
  end

  def score
    # byebug
  end
end
