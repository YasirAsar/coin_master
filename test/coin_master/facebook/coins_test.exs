defmodule CoinMaster.Facebook.CoinsTest do
  use CoinMaster.DataCase

  alias CoinMaster.Facebook.Coins

  describe "request_coin_search/1" do
    test "return request coin search message" do
      received_message =
        get_started_event_fixtures()
        |> Coins.request_coin_search()

      assert received_message == [request_coin_search_template_fixtures()]
    end
  end

  describe "send_coin_list/2" do
    test "when no coins found, return no coins found and request search templates" do
      received_message = Coins.send_coin_list([], search_event_fixtures())

      assert received_message == [
               coins_not_found_template_fixtures(),
               request_coin_search_template_fixtures()
             ]
    end

    test "when coin gecko returns coins, return coins quick reply template" do
      received_message =
        coins_fixtures()
        |> Coins.send_coin_list(search_event_fixtures())

      assert received_message == [send_coin_list_template_fixtures()]
    end
  end

  describe "send_coin_prices/2" do
    test "if price list was empty, return price not found and request search template" do
      received_message = Coins.send_coin_prices([], quick_reply_event_fixtures())

      assert received_message == [
               price_list_not_found_template_fixtures(),
               request_coin_search_template_fixtures()
             ]
    end

    test "if prices are available, return price list template" do
      received_message =
        coin_prices_fixtures()
        |> Coins.send_coin_prices(quick_reply_event_fixtures())

      assert received_message == [price_list_template_fixtures()]
    end
  end
end
