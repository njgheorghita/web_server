require 'sinatra'
require 'sinatra/reloader'
require 'pry'

class Guess
  attr_accessor :message, :color, :remaining, :number

  def initialize
    @number = rand(100)
    @message = ''
    @color = "red"
    @remaining = 5
  end

  def check_guess(input, cheat)
    if cheat.eql?('true')
      @message = "psst, the number is #{number}"
      @color = "purple"
    elsif !(1..100).to_a.include?(input.to_i)
      @message = "please make a guess (1-100)"
    else
      input = input.to_i
      @remaining -= 1
      if  @remaining == 0
          @remaining = 5
          @message = "you've lost, it was #{number}, sorry try again"
          @number = rand(100)
      else 
        if input > (number + 5)
          @message = "Way too high! \n remaining guesses : #{remaining}"
          @color = "red"
        elsif input < (number - 5)
          @message = "Way too low! \n remaining guesses : #{remaining}"
          @color = "red"
        elsif input > number
          @message = "Too high! \n remaining guesses : #{remaining}"
          @color = "#fc8f7e"
        elsif input < number
          @message = "Too low! \n remaining guesses : #{remaining}"
          @color = "#fc8f7e"
        else 
          @message = "You got it right! \n The secret number is #{number}"
          @remaining = 5
          @number = rand(100)
          @color = "green"
        end
      end
    end
  end
end

instance = Guess.new

get '/' do 
  guess = params['guess']
  cheat = params['cheat']
  message = instance.check_guess(guess, cheat)
  erb :index, :locals => {:number => instance.number, :message => instance.message, :color => instance.color}
end



