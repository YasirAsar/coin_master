defmodule CoinMaster.CoinGeckoTest do
  use CoinMaster.DataCase

  import Mox

  setup :verify_on_exit!

  alias CoinMaster.CoinGecko

  @coin_gecko_client Application.compile_env!(:coin_master, :coin_gecko_client)

  describe "search_coins/2" do
    test "for valid coin gecko response, return list of coins" do
      expect(@coin_gecko_client, :search_coins, fn string ->
        assert string == "bitcoin"
        search_coins_response_fixtures()
      end)

      assert coins_fixtures() == CoinGecko.search_coins("bitcoin", 5)
    end

    test "for error response, return empty list" do
      expect(@coin_gecko_client, :search_coins, fn string ->
        assert string == "wrong"
        {:error, "failed"}
      end)

      assert [] == CoinGecko.search_coins("wrong", 5)
    end
  end

  describe "get_coin/1" do
    test "for valid coin gecko response, return coin prices" do
      expect(@coin_gecko_client, :get_coin, fn id ->
        assert id == 1
        get_coin_prices_response_fixtures()
      end)

      assert coin_prices_fixtures() == CoinGecko.get_coin_prices(1)
    end

    test "for error response, return empty list" do
      expect(@coin_gecko_client, :get_coin, fn id ->
        assert id == -1
        {:error, "failed"}
      end)

      assert [] == CoinGecko.get_coin_prices(-1)
    end
  end
end
