defmodule CoinMaster.CoinGecko.CoinGeckoClientTest do
  use CoinMaster.DataCase

  import ExUnit.CaptureLog
  import Mox

  setup :verify_on_exit!

  alias CoinMaster.CoinGecko.CoinGeckoClient

  @http_client Application.compile_env!(:coin_master, :http_client)

  describe "search_coins/1" do
    test "search coins return valid response" do
      search_coins = search_coins_response_fixtures()

      expect(@http_client, :get, fn endpoint ->
        assert endpoint =~ "https://api.coingecko.com/api/v3/search/?query=bitcoin"

        search_coins
      end)

      "bitcoin"
      |> CoinGeckoClient.search_coins()
      |> then(fn response ->
        response == search_coins
      end)
      |> assert()
    end

    test "if search coins failed, return error" do
      expect(@http_client, :get, fn _endpoint ->
        {:error, "failed"}
      end)

      {response, log} =
        with_log(fn ->
          CoinGeckoClient.search_coins("bitcoin")
        end)

      assert response == :error
      assert log =~ "Error in CoinGecko search coins"
    end
  end

  describe "get_coin/1" do
    test "get coin return valid response" do
      get_coin = get_coin_prices_response_fixtures()

      expect(@http_client, :get, fn endpoint ->
        assert endpoint =~
                 "https://api.coingecko.com/api/v3/coins/bitcoin/market_chart/?vs_currency=usd&days=14&interval=daily"

        get_coin
      end)

      "bitcoin"
      |> CoinGeckoClient.get_coin()
      |> then(fn response ->
        response == get_coin
      end)
      |> assert()
    end

    test "if get coin failed, return error" do
      expect(@http_client, :get, fn _endpoint ->
        {:error, "failed"}
      end)

      {response, log} =
        with_log(fn ->
          CoinGeckoClient.get_coin("bitcoin")
        end)

      assert response == :error
      assert log =~ "Error in CoinGecko get coin"
    end
  end
end
