defmodule CoinMaster.Facebook.EventHandler do
  @moduledoc """
  This module has functions to handle different facebook message event.
  Perform relevant operations against the event and returns the templates.
  """

  alias CoinMaster.CoinGecko
  alias CoinMaster.Facebook.Coins
  alias CoinMaster.Facebook.EventParser
  alias CoinMaster.Facebook.Profile

  alias CoinMaster.Types

  @doc """
  Normal text message handled by this function.

  We are enabled nlp in facebook messenger. So, it will process the message before passing that to us.
  Return the message with the relevant information about the message.
  By using that information, we can proceed with message handling.

  If the message looks like greetings, we will return welcome and request coin search templates.
  Otherwise, it will go for coin search from coin gecko. Return relevant templates based on the search.
  """
  @spec handle_message(Types.messaging(), Types.event()) :: Types.templates()
  def handle_message(message, event) do
    greetings = EventParser.get_greetings_entity(event)

    if greetings && greetings["confidence"] > 0.8 do
      Profile.welcome_message(event) ++ Coins.request_coin_search(event)
    else
      message
      |> CoinGecko.search_coins(5)
      |> Coins.send_coin_list(event)
    end
  end

  @doc """
  Postback message handled by this function.

  Currently, we only have one postback response for get_started.
  So, whenever we receive get_started payload. We will return welcome and request coin search templates.
  """
  @spec handle_postback(Types.messaging(), Types.event()) :: Types.templates()
  def handle_postback(%{"payload" => "get_started"}, event) do
    Profile.welcome_message(event) ++ Coins.request_coin_search(event)
  end

  def handle_postback(_, event), do: Profile.something_went_wrong(event)

  @doc """
  Quick replay events are handled by this function.

  Based on the given payload, we are getting coin prices from coin Gecko.
  And returning relevant templates based on the coin Gecko response,
  """
  @spec handle_quick_reply(Types.messaging(), Types.event()) :: Types.templates()
  def handle_quick_reply(%{"payload" => payload}, event) do
    coin_prices =
      payload
      |> CoinGecko.get_coin_prices()
      |> Coins.send_coin_prices(event)

    coin_prices ++ Coins.request_coin_search(event)
  end

  def handle_quick_reply(_, event), do: Profile.something_went_wrong(event)

  @doc """
  If any other events are triggered other than message, postback and quick reply.
  Return something went wrong template.
  """
  @spec handle_something_went_wrong(Types.event()) :: Types.templates()
  def handle_something_went_wrong(event), do: Profile.something_went_wrong(event)
end
