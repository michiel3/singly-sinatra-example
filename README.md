# Sinatra Singly example


Example app using the Singly API with Sinatra (Ruby).

## Usage
	gem install shotgun
	gem install omniauth-singly
	gem install httparty
	  
	export SINGLY_ID=<your Singly app ID>
	export SINGLY_SECRET=<your Singly app secret>
	
	shotgun -p 4567 lib/application.rb
  
Now visit <http://lvh.me:4567>.