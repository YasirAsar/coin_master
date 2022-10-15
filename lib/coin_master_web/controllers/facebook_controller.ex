defmodule CoinMasterWeb.FacebookController do
  use CoinMasterWeb, :controller

  alias CoinMaster.Facebook

  def verify_webhook_token(conn, params) do
    if Facebook.verify_webhook(params) do
      conn
      |> put_resp_content_type("application/json")
      |> resp(200, params["hub.challenge"])
      |> send_resp()
    else
      conn
      |> put_resp_content_type("application/json")
      |> resp(403, Jason.encode!(%{status: "error", message: "unauthorized"}))
    end
  end

  def handle_event(conn, event) do
    Facebook.handle_event(event)

    conn
    |> put_resp_content_type("application/json")
    |> resp(200, Jason.encode!(%{status: "ok"}))
  end
end
