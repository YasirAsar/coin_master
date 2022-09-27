defmodule CoinMaster do
  @moduledoc """
  CoinMaster keeps the contexts that define your domain
  and business logic.

  Contexts are also responsible for managing your data, regardless
  if it comes from the database, an external API or others.
  """

  alias CoinMaster.Bot
  alias CoinMaster.Message
  alias CoinMaster.MessageHandler
  alias CoinMaster.Template

  def handle_event(event) do
    case Message.get_messaging(event) do
      %{"message" => message} ->
        MessageHandler.handle_message(message, event)

      _ ->
        error_template =
          Template.text(event, "Something went wrong. Our Engineers are working on it.")

        Bot.send_message(error_template)
    end
  end
end
