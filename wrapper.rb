require "httparty"

class Spacetraders
  def initialize(token)
    @token = token
  end

  def sendRequest(url, method='get', payload="{}")
    if method == 'get'
      response = HTTParty.get(url, headers: headers)
    elsif method = 'post'
      response = HTTParty.post(url, body: payload.to_json, headers: headers)
    end

    resp = JSON.parse(response.body)
    resp
  end

  def get_my_ships
    url = 'https://api.spacetraders.io/v2/my/ships/'
    sendRequest(url)
  end

  def view_market(systemSymbol, asteroidFieldWaypointSymbol)
    url = "https://api.spacetraders.io/v2/systems/#{systemSymbol}/waypoints/#{asteroidFieldWaypointSymbol}/market"
    puts url
    sendRequest(url)
  end

  def get_ship_cargo(shipSymbol)
    url = "https://api.spacetraders.io/v2/my/ships/#{shipSymbol}"
    resp = sendRequest(url)
    resp["data"]["cargo"]
  end

  def dock_ship(shipSymbol)
    url = "https://api.spacetraders.io/v2/my/ships/#{shipSymbol}/dock"
    sendRequest(url, "post")
  end

  def sell_cargo(shipSymbol, resource, no_units)
    url = "https://api.spacetraders.io/v2/my/ships/#{shipSymbol}/sell"
    payload = {
      "symbol": resource,
      "units": no_units
    }
    sendRequest(url, "post", payload)
  end

  private 

  def headers 
    {
      'Authorization' => "Bearer #{@token}",
      'Content-Type' => 'application/json'
    }
  end
  
end
