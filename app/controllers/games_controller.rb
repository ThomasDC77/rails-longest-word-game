require "json"
require "open-uri"

class GamesController < ApplicationController

  def new
    @letters = 10.times.map { ('a'..'z').to_a[rand(26)] }
  end

  def score
    @word = params[:word]
    @letters = params[:letters]
    url = "https://wagon-dictionary.herokuapp.com/#{@word}"
    dico = URI.open(url).read
    api = JSON.parse(dico)
    @word.split('').each do |letter|
      @score = "Sorry but #{@word} can't be built out of #{@letters}" if letter.!include?(@letters)
    end
    if api["found"] == true
      @score = "Congratulations! #{@word} is a valid English word"
    else
      @score = "Sorry but #{@word} does not seem to be a valid English word..."
    end
  end
end

# url = "https://wagon-dictionary.herokuapp.com/"
#       while word.include?(@letters)
#         if {found: true}
#           @score = "Congratulations! #{word} is a valid English word"
#         else {found: false}
#           @score = "Sorry but #{word} does not seem to be a valid English word..."
#         end
#       end
