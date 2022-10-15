defmodule CoinMaster.CoinGecko.CoinGeckoClient do
  @moduledoc """
  This module has functions to perform Coin Gecko API get operations.
  """

  @coin_gecko Application.compile_env!(:coin_master, :coin_gecko)
  @http_client Application.compile_env!(:coin_master, :http_client)

  alias CoinMaster.Types

  require Logger

  @doc """
  Search the coins by given string.
  """
  @callback search_coins(String.t()) :: Types.http_response()
  @spec search_coins(String.t()) :: Types.http_response()
  def search_coins(string) do
    endpoint = Path.join([@coin_gecko.base_url, "search", "?query=#{string}"])

    with {:error, reason} <- @http_client.get(endpoint) do
      Logger.error("Error in CoinGecko search coins, #{inspect(reason)}")
      :error
    end
  end

  @doc """
  Get the coin prices in USD by id from market chart for last 14 days.
  """
  @callback get_coin(String.t()) :: Types.http_response()
  @spec get_coin(String.t()) :: Types.http_response()
  def get_coin(id) do
    endpoint =
      Path.join([
        @coin_gecko.base_url,
        "coins",
        id,
        "market_chart",
        "?vs_currency=usd&days=14&interval=daily"
      ])

    with {:error, reason} <- @http_client.get(endpoint) do
      Logger.error("Error in CoinGecko get coin, #{inspect(reason)}")
      :error
    end
  end
end
