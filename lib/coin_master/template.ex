defmodule CoinMaster.Template do
  @moduledoc false

  alias CoinMaster.Message

  def text(event, text) do
    %{
      "recipient" => %{
        "id" => Message.get_sender(event)["id"]
      },
      "message" => %{"text" => text}
    }
  end
end
