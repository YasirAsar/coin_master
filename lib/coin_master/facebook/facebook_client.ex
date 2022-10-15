defmodule CoinMaster.Facebook.FacebookClient do
  @moduledoc """
  This module has functions to perform Facebook API operations.
  """

  alias CoinMaster.Facebook
  alias CoinMaster.Types

  require Logger

  @facebook_chat_bot Application.compile_env!(:coin_master, :facebook_chat_bot)
  @http_client Application.compile_env!(:coin_master, :http_client)

  @doc """
  Send normal text message to facebook.
  """
  @callback send_message(map()) :: Types.http_response()
  @spec send_message(map()) :: Types.http_response()
  def send_message(body) do
    token_path = "?access_token=#{Facebook.facebook_secrets(:page_access_token)}"

    endpoint =
      Path.join([@facebook_chat_bot.base_url, @facebook_chat_bot.message_url, token_path])

    with {:error, reason} <- @http_client.post(endpoint, body) do
      Logger.error("Error in sending message, #{inspect(reason)}")
      :error
    end
  end

  @doc """
  Set facebook page profile setting.
  """
  @callback set_message_profile(map()) :: Types.http_response()
  @spec set_message_profile(map()) :: Types.http_response()
  def set_message_profile(body) do
    token_path = "?access_token=#{Facebook.facebook_secrets(:page_access_token)}"

    endpoint =
      Path.join([@facebook_chat_bot.base_url, @facebook_chat_bot.message_profile, token_path])

    with {:error, reason} <- @http_client.post(endpoint, body) do
      Logger.error("Error in setting profile, #{inspect(reason)}")
      :error
    end
  end

  @doc """
  Get sender profile details.
  """
  @callback get_profile(map()) :: Types.http_response()
  @spec get_profile(map()) :: Types.http_response()
  def get_profile(sender) do
    token_path = "?access_token=#{Facebook.facebook_secrets(:page_access_token)}"
    endpoint = Path.join([@facebook_chat_bot.base_url, sender["id"], token_path])

    with {:error, reason} <- @http_client.get(endpoint) do
      Logger.error("Error in getting profile, #{inspect(reason)}")
      :error
    end
  end
end
