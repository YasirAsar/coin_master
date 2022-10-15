defmodule CoinMaster.Facebook.EventParser do
  @moduledoc """
  This module has functions to parse the facebook events.
  """

  alias CoinMaster.Types

  @facebook_client Application.compile_env!(:coin_master, :facebook_client)

  @doc """
  Return the messaging map from the event.
  """
  @spec get_messaging(Types.event()) :: Types.messaging()
  def get_messaging(%{"entry" => [%{"messaging" => [messaging | _]} | _]}), do: messaging

  @doc """
  Return the sender details from the event.
  """
  @spec get_sender(Types.event()) :: map()
  def get_sender(event) do
    event
    |> get_messaging()
    |> Map.get("sender")
  end

  @doc """
  Return the recipient details from the event.
  """
  @spec get_recipient(Types.event()) :: map()
  def get_recipient(event) do
    event
    |> get_messaging()
    |> Map.get("recipient")
  end

  @doc """
  Get the sender message from the event.
  """
  @spec get_message(Types.event()) :: map()
  def get_message(event) do
    event
    |> get_messaging()
    |> Map.get("message", %{})
  end

  @doc """
  Get the wit$greeting details from the message.
  If the details not found, return false.
  """
  @spec get_greetings_entity(Types.event()) :: map() | false
  def get_greetings_entity(event) do
    event
    |> get_message()
    |> Map.get("nlp")
    |> greetings_entity()
  end

  @doc """
  Get the event sender profile details by using facebook API.
  If something went wrong in getting, return empty map.
  """
  @spec get_profile(Types.event()) :: map()
  def get_profile(event) do
    event
    |> get_sender()
    |> @facebook_client.get_profile()
    |> case do
      {:ok, profile} -> profile
      _ -> %{}
    end
  end

  defp greetings_entity(%{"traits" => %{"wit$greetings" => [entity | _]}}), do: entity
  defp greetings_entity(_), do: false
end
