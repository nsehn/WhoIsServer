require 'sinatra'
require 'whois' #this is a Ruby gem
require 'sinatra/reloader'
require 'json'
require 'rubygems'
require 'debugger'
set :public_folder, File.dirname(__FILE__) + '/Public'

get '/' do
	erb :index
end

post '/whois' do #the sinatra will respond to this post /whois
	puts params #not needed. This tells us, the developer, what is in params
	# @state = "unavailable" #instance variable that is set to unavailabe as a default value
	domain = params[:domain] #params contains all the data that came from the post request which in this case came from the index.erb code
				# the instance variable does not have to be the same name is the :word. :domain could be any word as long as it is exists in params (it exists in the index.erb code)
  	domaintype = params[:domaintype]
  	#perform whois lookup
  	domain_extensions = params[:domaintype].values

  	@query = []
  	domain_extensions.each do |extension|
  		result = Whois::query(domain + extension) #Query is a part of the whois gem
  		@query << result
  	end

  	erb :result
end