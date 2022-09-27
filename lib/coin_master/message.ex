defmodule CoinMaster.Message do
  @moduledoc false

  @facebook_chat_bot Application.compile_env!(:coin_master, :facebook_chat_bot)

  def get_messaging(%{"entry" => [%{"messaging" => [messaging | _]} | _]}), do: messaging

  def get_sender(event) do
    event
    |> get_messaging()
    |> Map.get("sender")
  end

  def get_recipient(event) do
    event
    |> get_messaging()
    |> Map.get("recipient")
  end

  def get_message(event) do
    event
    |> get_messaging()
    |> Map.get("message")
  end

  def get_profile(event) do
    base_url = @facebook_chat_bot.base_url
    version = @facebook_chat_bot.api_version
    page_token = @facebook_chat_bot.page_access_token
    token_path = "?access_token=#{page_token}"

    sender = get_sender(event)

    profile_path = Path.join([base_url, version, sender["id"], token_path])

    case HTTPoison.get(profile_path) do
      {:ok, response} ->
        {:ok, Jason.decode!(response.body)}

      {:error, error} ->
        {:enoprofile, error}
    end
  end

  def greet(first_name) do
    """
    Hello #{first_name} :)
    Welcome to Crypto Gecko
    """
  end
end
