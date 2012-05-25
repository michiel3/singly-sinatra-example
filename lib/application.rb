require "sinatra"
require 'omniauth-singly'
require "httparty"

SINGLY_API_BASE = "https://api.singly.com"

enable :sessions
set :public_folder, 'public'

use OmniAuth::Builder do
  provider :singly, ENV['SINGLY_ID'], ENV['SINGLY_SECRET']
end


get "/" do
  if session[:access_token]
    @profiles = HTTParty.get("#{SINGLY_API_BASE}/profiles", {
                  :query => { :access_token => session[:access_token] }
                }).parsed_response
  end
  
  if @profiles && @profiles['facebook']
    
    @photos = HTTParty.get("#{SINGLY_API_BASE}/services/facebook/photos", { 
                :query => { :access_token => session[:access_token] }
              }).parsed_response
              
      
            
    puts @photos
    
    erb :connected
  else
    erb :not_connected
  end
end

get "/auth/singly/callback" do
  auth = request.env['omniauth.auth']
  puts auth
  session[:access_token] = auth.credentials.token
  redirect "/"
end

get "/logout" do
  session.clear
  redirect "/"
end