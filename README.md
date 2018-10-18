# README

This project was a paired project to be completed over 12 days.  We inherited an existing code base (Brownfield) along with a spec harness to support our progress. The app is a Battleship game played via API calls.

The many goals of this project included:
* Build out the internal API to support calls.
* Make API calls to consume our own API (eat own dogfood)
* Implement Mailer with Activation Link
* Build funtionality to the game for two player interaction (2 human players)


Interested in cloning this app? Follow these instructions on your local:
```
1. git clone git@github.com:KathleenYruegas/battleshift.git
2. bundle install
3. rake db:{create,migrate,seed}
  ```
To get an api key, you can register an account and use the email link.

Some endpoints of the API you can hit:
The seed file will set you up with a game and ships already placed, so the first thing you'll need to do is send a shot over.
For example, you can send your POST request to `https://tranquil-ridge-40054.herokuapp.com/api/v1/games/1/shots` along with your target in the params, `ex: {target: "A1"}`.


Notable Technology:
1. Ruby 2.4.1
2. Rails 5.1.6
3. RSpec

How to run the test suite
* Navigate to the root of the directory and type in `rspec`. 

The Team
1. Claire Beauvais `github.com/clairebvs`
2. Kathleen Yruegas `github.com/kathleenyruegas`
