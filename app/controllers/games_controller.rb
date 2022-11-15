require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = (0...10).map { ('A'..'Z').to_a[rand(26)] }
  end

  def score
    @word = params[:word]
    if include?(@word.upcase, @letters)
      if english_word?(@word)
        @score = "Sorry but #{@word.upcase} does not seem to be a valid english word"
      else
        @score = "Congratulations #{@word.upcase} is a valid english word!"
      end
    else
      @score = "Sorry but #{@word.upcase} can't be build out of #{letters}"
    end
    @score
  end

  def include?(word, grid)
    word.chars.all? { |letter| word.count(letter) <= grid.count(letter) }
  end

  def english_word?(word)
    response = URI.open("https://wagon-dictionary.herokuapp.com/#{word.downcase}")
    @words = JSON.parse(response.read)
    # @words['found']
  end
end
