defmodule CoinMaster.Bot do
  @moduledoc false

  @facebook_chat_bot Application.compile_env!(:coin_master, :facebook_chat_bot)

  require Logger

  def verify_webhook(params) do
    mode = params["hub.mode"]
    token = params["hub.verify_token"]

    mode == "subscribe" && token == @facebook_chat_bot.webhook_verify_token
  end

  def send_message(msg_template) do
    endpoint = bot_endpoint()
    headers = [{"content-type", "application/json"}]
    msg_template = Jason.encode!(msg_template)

    case HTTPoison.post(endpoint, msg_template, headers) do
      {:ok, _response} ->
        Logger.info("Message Sent to Bot")

      {:error, reason} ->
        Logger.error("Error in sending message to bot, #{inspect(reason)}")
        :error
    end
  end

  def bot_endpoint() do
    base_url = @facebook_chat_bot.base_url
    version = @facebook_chat_bot.api_version
    message_url = @facebook_chat_bot.message_url
    access_token = @facebook_chat_bot.page_access_token
    token_path = "?access_token=#{access_token}"

    Path.join([base_url, version, message_url, token_path])
  end
end
