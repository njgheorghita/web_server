require 'sinatra'
require 'sinatra/reloader'

class Guess
  attr_reader :number
  attr_accessor :message

  def initialize
    @number = rand(100)
    @message = ''
  end

  def check_guess(input)
    return if input.nil?
    if (0..100).to_a.include?(input)
      if input > (number + 5)
        @message = "Way too high!"
      elsif input < (number - 5)
        @message = "Way too low!"
      elsif input > number
        @message = "Too high!"
      elsif input < number
        @message = "Too low!"
      else 
        @message = "You got it right! \n The secret number is #{number}"
      end
    else
      @message = "Please guess between 0 - 100"
    end
  end
end

instance = Guess.new

get '/' do 
  guess = params['guess'].to_i
  message = instance.check_guess(guess)
  erb :index, :locals => {:number => instance.number, :message => instance.message}
end



