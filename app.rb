require "sinatra"
require_relative "adding_exercise.rb"
require_relative "subtraction_exercise.rb"
require_relative "multiply_exercise.rb"
require_relative "division_exercise.rb"

enable :sessions

get '/' do 
	erb :login_info, locals: {error_message: ""}
 
end

post "/login" do
	username = params[:username]
	password = params[:password]
	invalid_info = "Invalid Username and Password, please try again."
	if username == "Cookie" && password == "dougH"
		redirect '/full_name?username=' + username + '&password=' + password
	elsif username == "Ice" && password == "creaM"
	    redirect '/full_name?username=' + username + '&password=' + password
	elsif username == "Brownie" && password == "biteS"
	    redirect '/full_name?username=' + username + '&password=' + password
	else
		erb :login_info, locals: {error_message: invalid_info}
	end
end

get '/full_name' do
	erb :full_name
end

post '/full_name' do
	first_name = params[:first_name]
	last_name = params[:last_name]
	redirect '/options?first_name=' + first_name + '&last_name=' + last_name
end

get '/options' do
	first_name = params[:first_name]
	last_name = params[:last_name]
	erb :options, locals: {first_name: first_name, last_name: last_name}
end

post '/options' do
	first_name = params[:first_name]
	last_name = params[:last_name]
	session[:option] = params[:option]
	p session[:option]
	redirect '/numbers?first_name=' + first_name + '&last_name=' + last_name
end

get '/numbers' do
	first_name = params[:first_name]
	last_name = params[:last_name]
	erb :numbers, locals: {first_name: first_name, last_name: last_name}
end

post '/numbers' do
	first_name = params[:first_name]
	last_name = params[:last_name]
	number_1 = params[:number_1]
	number_2 = params[:number_2]
	if session[:option] == "+"
		session[:results] = addition(number_1.to_i,number_2.to_i)
	elsif session[:option] == "-"
		session[:results] = subtraction(number_1.to_i,number_2.to_i)
	elsif session[:option] == "*"
		session[:results] = multiply(number_1.to_i,number_2.to_i)
	elsif session[:option] == "/"
		session[:results] = division(number_1.to_i,number_2.to_i)
	end
	redirect '/results?first_name=' + first_name + '&last_name=' + last_name + '&number_1=' + number_1 + '&number_2=' + number_2 
end

get '/results' do
	first_name = params[:first_name]
	last_name = params[:last_name]
	number_1 = params[:number_1]
	number_2 = params[:number_2]
	erb :final_page, locals: {first_name: first_name, last_name: last_name, option: session[:option], number_1: number_1, number_2: number_2, results: session[:results]}
end
 
post '/return' do
	first_name = params[:first_name]
	last_name = params[:last_name]
	options = params[:option]
	number_1 = params[:number_1]
	number_2 = params[:number_2]
	redirect '/options?first_name=' + first_name + '&last_name=' + last_name
end



