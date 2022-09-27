defmodule CoinMaster.MessageHandler do
  @moduledoc false

  alias CoinMaster.Bot
  alias CoinMaster.Message
  alias CoinMaster.Template

  def handle_message(_message, event) do
    {:ok, profile} = Message.get_profile(event)

    message =
      profile
      |> Map.get("first_name")
      |> Message.greet()

    event
    |> Template.text(message)
    |> Bot.send_message()
  end
end
