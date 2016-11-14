require 'sinatra'
require 'sinatra/reloader'

var = rand(100)

get '/' do 
  "The  is #{var}"
end