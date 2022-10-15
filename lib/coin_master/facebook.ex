defmodule CoinMaster.Facebook do
  @moduledoc """
  This module has facebook communication business functions
  """

  alias CoinMaster.Facebook.EventHandler
  alias CoinMaster.Facebook.EventParser
  alias CoinMaster.Types

  @facebook_client Application.compile_env!(:coin_master, :facebook_client)
  @facebook_message_delay Application.compile_env!(:coin_master, :facebook_message_delay)

  @doc """
  Verify facebook webhook token and mode.
  """
  @spec verify_webhook(map) :: boolean()
  def verify_webhook(params) do
    mode = params["hub.mode"]
    token = params["hub.verify_token"]

    mode == "subscribe" && token == facebook_secrets(:webhook_verify_token)
  end

  @doc """
  This function handle all facebook message events.
  """
  @spec handle_event(Types.event()) :: list()
  def handle_event(event) do
    event
    |> EventParser.get_messaging()
    |> case do
      %{"message" => %{"quick_reply" => quick_reply}} ->
        EventHandler.handle_quick_reply(quick_reply, event)

      %{"message" => %{"text" => text}} ->
        EventHandler.handle_message(text, event)

      %{"postback" => postback} ->
        EventHandler.handle_postback(postback, event)

      _ ->
        EventHandler.handle_something_went_wrong(event)
    end
    |> send_messages()
  end

  @doc """
  Fetch facebook secrets from config based on the given key.
  """
  @spec facebook_secrets(atom()) :: String.t()
  def facebook_secrets(key) do
    Application.fetch_env!(:coin_master, :facebook_secrets)[key]
  end

  defp send_messages(templates) do
    for template <- templates do
      @facebook_client.send_message(template)
      :timer.sleep(@facebook_message_delay)
    end
  end
end
