require "sinatra"
require "openssl"
require "pry"

use Rack::Session::Cookie, {
  secret: "keep_it_secret_keep_it_safe"
}

def generate_hmac(data, secret)
  OpenSSL::HMAC.hexdigest(OpenSSL::Digest::SHA1.new, secret, data)
end

def game(choice)
  shapes = ["rock","paper","scissors"]
  if session.has_key?(:pscore)
    @pscore = session[:pscore].to_i
  else
    @pscore = 0
  end
  if session.has_key?(:cscore)
    @cscore = session[:cscore].to_i
  else
    @cscore = 0
  end
  @output = ''
  @game_over = ''
  case choice
  when "rock"
    comp_choice = shapes[rand(3)]
    if comp_choice == "scissors"
      @output = "You chose rock. Computer chose scissors. Rock beats scissors. You win the round."
      @pscore+=1
    end
    if comp_choice == "paper"
      @output = "You chose rock.  Computer chose paper. Paper beats rock.  Computer wins the round."
      @cscore+=1
    end
    @output = "Tie, choose again." if comp_choice == "rock"
  when "paper"
    comp_choice = shapes[rand(3)]
    if comp_choice == "rock"
      @output = "You chose paper. Computer chose rock. Paper beats rock. You win the round."
      @pscore +=1
    end
    if comp_choice == "scissors"
      @output = "You chose paper. Computer chose scissors. Scissors beats paper. Computer wins the round."
      @cscore += 1
    end
    @output = "Tie, choose again." if comp_choice == "paper"
  when "scissors"
    comp_choice = shapes[rand(3)]
    if comp_choice == "paper"
      @output = "You chose scissors. Computer chose paper. Scissors beats paper. You win the round."
      @pscore +=1
    end
    if comp_choice == "rock"
      @output = "You chose scissors. Computer chose rock. Rock beats scissors. Computer wins the round."
      @cscore += 1
    end
    @output = "Tie, choose again." if comp_choice == "scissors"
  end
  if @pscore == 2 || @cscore == 2
    winner = @pscore > @cscore ? "Player" : "Computer"
    @game_over = "#{winner} wins!"
  end
end

get '/' do
  redirect '/mmorps'
end

get '/mmorps' do
  session[:pscore] = '0' unless session.has_key?(:pscore)
  session[:cscore] = '0' unless session.has_key?(:cscore)
  session[:output] = '' unless session.has_key?(:output)
  session[:gameover] = '' unless session.has_key?(:gameover)
  erb :game
end

post '/choose' do
  game(params['choice'])
  session[:pscore] = @pscore
  session[:cscore] = @cscore
  session[:output] = @output
  session[:gameover] = @game_over
  redirect '/mmorps'
end

post '/reset' do
  session.clear
  redirect 'mmorps'
end