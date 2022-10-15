defmodule CoinMaster.FacebookTest do
  @moduledoc false

  use CoinMaster.DataCase

  import Mox

  setup :verify_on_exit!

  alias CoinMaster.Facebook

  @coin_gecko_client Application.compile_env!(:coin_master, :coin_gecko_client)
  @facebook_client Application.compile_env!(:coin_master, :facebook_client)

  describe "verify_webhook/1" do
    test "for valid params, return true" do
      assert Facebook.verify_webhook(verify_webhook_token_valid_params_fixtures())
    end

    test "for invalid params, return false" do
      refute Facebook.verify_webhook(verify_webhook_token_invalid_params_fixtures())
    end
  end

  describe "handle_event/1" do
    test "quick_reply message will get and send coin prices to facebook" do
      expect(@coin_gecko_client, :get_coin, fn string ->
        assert string == "bitcoin"

        get_coin_prices_response_fixtures()
      end)

      expect(@facebook_client, :send_message, fn template ->
        assert template == price_list_template_fixtures()
        {:ok, %{}}
      end)

      expect(@facebook_client, :send_message, fn template ->
        assert template == request_coin_search_template_fixtures()
        {:ok, %{}}
      end)

      quick_reply_event_fixtures()
      |> Facebook.handle_event()
    end

    test "greeting message will send welcome and coin search request to facebook" do
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

      greetings_event_fixtues()
      |> Facebook.handle_event()
    end

    test "for get_started postback message will send welcome and coin search request to facebook" do
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

      get_started_event_fixtures()
      |> Facebook.handle_event()
    end
  end
end
