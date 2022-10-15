defmodule CoinMaster.CoinGecko.CoinGeckoFixtures do
  @moduledoc false

  def search_coins_response_fixtures do
    {:ok,
     %{
       "categories" => [],
       "coins" => [
         %{
           "api_symbol" => "2x2",
           "id" => "2x2",
           "large" => "https://assets.coingecko.com/coins/images/9688/large/logo_%2817%29.png",
           "market_cap_rank" => 1811,
           "name" => "2X2",
           "symbol" => "2X2",
           "thumb" => "https://assets.coingecko.com/coins/images/9688/thumb/logo_%2817%29.png"
         }
       ]
     }}
  end

  def get_coin_prices_response_fixtures do
    {:ok,
     %{
       "market_caps" => [[1_660_018_478_000, 1_274_737.220978339]],
       "prices" => [[1_660_018_478_000, 2.38741791859835e-4]],
       "total_volumes" => [[1_660_018_478_000, 0.17905634389487626]]
     }}
  end

  def coins_fixtures do
    [
      %{
        "api_symbol" => "2x2",
        "id" => "2x2",
        "large" => "https://assets.coingecko.com/coins/images/9688/large/logo_%2817%29.png",
        "market_cap_rank" => 1811,
        "name" => "2X2",
        "symbol" => "2X2",
        "thumb" => "https://assets.coingecko.com/coins/images/9688/thumb/logo_%2817%29.png"
      }
    ]
  end

  def coin_prices_fixtures do
    [[1_660_018_478_000, 2.38741791859835e-4]]
  end
end
