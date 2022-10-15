defmodule CoinMaster.CoinGecko do
  @moduledoc """
  This module coin gecko communication functions.
  """

  @coin_gecko_client Application.compile_env!(:coin_master, :coin_gecko_client)

  @doc """
  Search coins on the Coin Gecko and returns the coin list.
  If something went wrong with the response, return empty list.
  """
  @spec search_coins(String.t(), integer()) :: list()
  def search_coins(string, coin_count) do
    case @coin_gecko_client.search_coins(string) do
      {:ok, response} ->
        response
        |> Map.get("coins", [])
        |> Enum.take(coin_count)

      _ ->
        []
    end
  end

  @doc """
  Get the coin prices for given id.
  If something went wrong with the response, return empty list.
  """
  @spec get_coin_prices(String.t()) :: list()
  def get_coin_prices(id) do
    case @coin_gecko_client.get_coin(id) do
      {:ok, response} ->
        Map.get(response, "prices", [])

      _ ->
        []
    end
  end
end
