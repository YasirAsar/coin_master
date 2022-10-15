defmodule CoinMaster.Facebook.CoinsFixtures do
  @moduledoc false

  def request_coin_search_template_fixtures do
    %{
      "message" => %{"text" => "Here, You can search coins by name or ID."},
      "recipient" => %{"id" => "1234567"}
    }
  end

  def coins_not_found_template_fixtures do
    %{
      "message" => %{
        "text" => "Coins not found for the given search. Try other search!"
      },
      "recipient" => %{"id" => "1234567"}
    }
  end

  def send_coin_list_template_fixtures do
    %{
      "message" => %{
        "quick_replies" => [
          %{"content_type" => "text", "payload" => "2x2", "title" => "2X2"}
        ],
        "text" => "I've found top 5 matches!, Kindly select the coin"
      },
      "recipient" => %{"id" => "1234567"}
    }
  end

  def price_list_not_found_template_fixtures do
    %{
      "message" => %{
        "text" => "Price list not found for given coin. Try other search!"
      },
      "recipient" => %{"id" => "1234567"}
    }
  end

  def price_list_template_fixtures do
    %{
      "message" => %{
        "text" => "Coin's prices in USD for the last 14 days.\n1. 2022-08-09 - 2.39e-4"
      },
      "recipient" => %{"id" => "1234567"}
    }
  end
end
