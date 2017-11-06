class PokemonController < ApplicationController

  def index
    res = HTTParty.get("http://pokeapi.co/api/v2/pokemon/pikachu/")
    body = JSON.parse(res.body)
    puts body["name"] # should be "pikachu"
    @pokemon = body

    res = HTTParty.get("https://api.giphy.com/v1/gifs/search?api_key=#{ENV["GIPHY_KEY"]}&q=#{@pokemon["name"]}&rating=g")
    body = JSON.parse(res.body)
    gif_url = body["data"][0]["url"]
    render json: {
      "id": "#{@pokemon["id"]}",
      "name": "#{@pokemon["name"]}",
      "types": "#{@pokemon["types"][0]["type"]["name"]}",
      "picture": "#{gif_url}"


    }

  end
  def show

  end
end
