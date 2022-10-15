defmodule CoinMaster.Facebook.EventHandlerTest do
  use CoinMaster.DataCase

  import Mox

  setup :verify_on_exit!

  alias CoinMaster.Facebook.EventHandler

  @coin_gecko_client Application.compile_env!(:coin_master, :coin_gecko_client)
  @facebook_client Application.compile_env!(:coin_master, :facebook_client)

  describe "handle_message/2" do
    test "if greetings message was passed, return welcome and coin search templates" do
      expect(@facebook_client, :get_profile, fn _args ->
        {:ok, profile_fixtures()}
      end)

      greetings_event_message_fixtues()
      |> EventHandler.handle_message(greetings_event_fixtues())
      |> then(fn templates ->
        templates == [
          welcome_message_template_fixtures(),
          request_coin_search_template_fixtures()
        ]
      end)
      |> assert()
    end

    test "Other than greeting text, coin search performed" do
      expect(@coin_gecko_client, :search_coins, fn _ ->
        search_coins_response_fixtures()
      end)

      search_event_message_fixtures()
      |> EventHandler.handle_message(search_event_fixtures())
      |> then(fn templates ->
        templates == [send_coin_list_template_fixtures()]
      end)
      |> assert()
    end
  end

  describe "handle_postback/2" do
    test "for get_started payload, return welcome and request coin search template" do
      expect(@facebook_client, :get_profile, fn _args ->
        {:ok, profile_fixtures()}
      end)

      get_started_event_message_fixtures()
      |> EventHandler.handle_postback(get_started_event_fixtures())
      |> then(fn templates ->
        templates == [
          welcome_message_template_fixtures(),
          request_coin_search_template_fixtures()
        ]
      end)
      |> assert()
    end

    test "other than get_started payload, return something went wrong template" do
      %{}
      |> EventHandler.handle_postback(get_started_event_fixtures())
      |> then(fn templates ->
        templates == [something_went_wrong_template_fixtures()]
      end)
      |> assert()
    end
  end

  describe "handle_quick_reply/2" do
    test "for coin payload, return coin price list and request coin search templates" do
      expect(@coin_gecko_client, :get_coin, fn _ ->
        get_coin_prices_response_fixtures()
      end)

      quick_reply_event_message_fixtures()
      |> EventHandler.handle_quick_reply(quick_reply_event_fixtures())
      |> then(fn templates ->
        templates == [price_list_template_fixtures(), request_coin_search_template_fixtures()]
      end)
      |> assert()
    end

    test "if payload not matched, return something went wrong template" do
      %{}
      |> EventHandler.handle_quick_reply(quick_reply_event_fixtures())
      |> then(fn templates ->
        templates == [something_went_wrong_template_fixtures()]
      end)
      |> assert()
    end
  end

  describe "handle_something_went_wrong/2" do
    test "return something went wrong template" do
      get_started_event_fixtures()
      |> EventHandler.handle_something_went_wrong()
      |> then(fn templates ->
        templates == [something_went_wrong_template_fixtures()]
      end)
      |> assert()
    end
  end
end
