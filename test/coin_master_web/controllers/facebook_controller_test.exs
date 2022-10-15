defmodule CoinMasterWeb.FacebookControllerTest do
  use CoinMasterWeb.ConnCase

  import Mox

  setup :verify_on_exit!

  @facebook_client Application.compile_env!(:coin_master, :facebook_client)

  describe "verify_webhook_token/2" do
    test "for valid params, return challenge as response", %{conn: conn} do
      params = verify_webhook_token_valid_params_fixtures()

      conn
      |> get(Routes.facebook_path(conn, :verify_webhook_token), params)
      |> json_response(200)
      |> then(fn response ->
        response == 123
      end)
      |> assert()
    end

    test "for invalid params, return unauthorized", %{conn: conn} do
      params = verify_webhook_token_invalid_params_fixtures()

      conn
      |> get(Routes.facebook_path(conn, :verify_webhook_token), params)
      |> json_response(403)
      |> then(fn response ->
        response == %{"message" => "unauthorized", "status" => "error"}
      end)
      |> assert()
    end
  end

  describe "handle_event/2" do
    test "for get_started postback, send welcome and search coin request to facebook", %{
      conn: conn
    } do
      expect(@facebook_client, :get_profile, fn _args ->
        {:ok, profile_fixtures()}
      end)

      expect(@facebook_client, :send_message, fn template ->
        assert template == welcome_message_template_fixtures()
        {:ok, %{}}
      end)

      expect(@facebook_client, :send_message, fn template ->
        assert template == request_coin_search_template_fixtures()
        {:ok, %{}}
      end)

      params = get_started_event_fixtures()

      conn
      |> post(Routes.facebook_path(conn, :handle_event), params)
      |> json_response(200)
      |> then(fn response ->
        response == %{"status" => "ok"}
      end)
      |> assert()
    end
  end
end
