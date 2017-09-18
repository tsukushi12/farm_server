require 'bundler'
Bundler.require
require 'sinatra/reloader'

set :bind, "0.0.0.0"

get '/' do
	'Hello world'
end

get '/watering_form' do
	erb :watering_form
end

post '/watering' do
	@id = params[:id]
	File.open("queue.txt", "w") do |f| 
		f.write("on")
	end
	redirect :watering_form
end

get '/queue' do
	qu = "off"
	File.open("queue.txt", "r") do |f|
		qu = f.read
	end
	qu
end

get '/completion' do
	File.open("queue.txt", "w") do |f|
		f.write("off")
	end
	File.open("log.txt", "a")do |f|
		f.puts(Time.now.strftime("%Y-%m-x %H時 %M分 %S秒"))
	end
	"ok"
end
