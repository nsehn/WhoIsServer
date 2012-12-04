require 'sinatra'
require 'whois' #this is a Ruby gem
require 'sinatra/reloader'
require 'json'
require 'rubygems'
require 'debugger'
set :public_folder, File.dirname(__FILE__) + '/Public'

get '/' do
erb:index
end

post '/searchedDomain/?' do #the sinatra will respond to this post /searchedDomain
	puts 'Hey we are in here'
	w = Whois::Client.new
	lookup = params[:domain]#need to figure out how this ruby is going to read json
	query = w.query(lookup)
	query.available?

	if query.available?
		"This is available!"
	else
		"This is not available. Please try again!"
	end
#Need to find how sinatra (which is the server) sends the json back to client
end
# the sinatra exposes the code to the internet. It enables Ruby to do what it needs to and to get our result.
# The user entered some text. The text is converted into JSON by Javascript and HTML (which makes up the website)
# and is sent and accepted by the server (the server is the Ruby code in this case and reads JSON).
# Data sent from Javascript -> Server by speaking in JSON.
# The server takes the JSON, reads it, and converts it into a Ruby object which in this code is called query. 
# The object queries and returns a true or false in JSON to the client (the client is the Javascript)
# using the function available? 