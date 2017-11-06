class PokemonController < ApplicationController

  def index
    response = HTTParty.get("http://pokeapi.co/api/v2/pokemon/pikachu/")
    if response.parsed_response["detail"] == "Not found."
      render json: {
        status: "error",
        code: 404,
        message: "Can't find a pokemon by that name"},
        :status => 404
    else
      pokemon_json = parsed_pokemon(response)
      render json: pokemon_json
    end

  end
  def show
    response = HTTParty.get("http://pokeapi.co/api/v2/pokemon/#{params[:id]}/")
    if response.parsed_response["detail"] == "Not found."
      render json: {
        status: "error",
        code: 404,
        message: "Can't find a pokemon by that name"},
        :status => 404
    else
      pokemon_json = parsed_pokemon(response)
      render json: pokemon_json
    end
  end

  private

  def parsed_pokemon(response)
    body = JSON.parse(response.body)
    pokemon = body
    res = HTTParty.get("https://api.giphy.com/v1/gifs/random?api_key=#{ENV["GIPHY_KEY"]}&tag=#{pokemon["name"]}&rating=g")
    body = JSON.parse(res.body)
    gif_url = body["data"]["url"]
    return {
      "id": "#{pokemon["id"]}",
      "name": "#{pokemon["name"]}",
      "types": "#{pokemon["types"][0]["type"]["name"]}",
      "picture": "#{gif_url}"
    }
  end
end
