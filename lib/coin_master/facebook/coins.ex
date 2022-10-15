defmodule CoinMaster.Facebook.Coins do
  @moduledoc """
  This module has facebook message templates for coins.
  """

  alias CoinMaster.Facebook.Template

  @doc """
  Request the user to perform coin search template.
  """
  def request_coin_search(event) do
    [Template.text(event, "Here, You can search coins by name or ID.")]
  end

  @doc """
  Template for showing list of coins.

  If the coin was not found, return coin not found and request coin search templates.
  """
  def send_coin_list([], event) do
    coins_not_found =
      Template.text(event, "Coins not found for the given search. Try other search!")

    [coins_not_found | request_coin_search(event)]
  end

  def send_coin_list(coins, event) do
    replies = Enum.map(coins, fn coin -> {coin["name"], coin["id"]} end)

    template_title = "I've found top 5 matches!, Kindly select the coin"

    [Template.quick_replies(event, template_title, replies)]
  end

  @doc """
  Template for show list coin prices.

  If the coin price was not found, return price not found and request coin search templates.
  """
  def send_coin_prices([], event) do
    price_not_found =
      Template.text(event, "Price list not found for given coin. Try other search!")

    [price_not_found | request_coin_search(event)]
  end

  def send_coin_prices(prices, event) do
    text = format_prices(prices)

    [Template.text(event, text)]
  end

  # In some case, CoinGecko returning 15 price list.
  # It was including two records for current date.
  # One is start of current day's price and another one current price.
  # So, here we are removing the duplicates.
  defp format_prices(prices) do
    initial_message = "Coin's prices in USD for the last 14 days."

    prices
    |> Enum.map(fn [date, price] ->
      date =
        date
        |> div(1000)
        |> DateTime.from_unix()
        |> elem(1)
        |> DateTime.to_date()
        |> Date.to_string()

      [date, Float.round(price, 6)]
    end)
    |> Enum.uniq_by(fn [date, _] -> date end)
    |> Enum.reverse()
    |> Enum.with_index(1)
    |> Enum.reduce(initial_message, fn {[date, price], idx}, acc ->
      acc <>
        "\n" <>
        "#{idx}. " <> date <> " - #{price}"
    end)
  end
end
