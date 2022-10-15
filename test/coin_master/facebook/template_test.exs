defmodule CoinMaster.Facebook.TemplateTest do
  use CoinMaster.DataCase

  alias CoinMaster.Facebook.Template

  describe "get_started/0" do
    test "return expected map" do
      assert %{"get_started" => %{"payload" => "get_started"}} == Template.get_started()
    end
  end

  describe "text/2" do
    test "return expect map" do
      response =
        get_started_event_fixtures()
        |> Template.text("hello")

      expected_response = %{
        "message" => %{"text" => "hello"},
        "recipient" => %{"id" => "1234567"}
      }

      assert response == expected_response
    end
  end

  describe "quick_replies/3" do
    test "return expect map" do
      template_tile = "I've found top 5 matches!, Kindly select the coin"

      replies = [
        {"Bitcoin", "bitcoin"},
        {"Wrapped Bitcoin", "wrapped-bitcoin"},
        {"Bitcoin Cash", "bitcoin-cash"},
        {"Bitcoin SV", "bitcoin-cash-sv"},
        {"Bitcoin Gold", "bitcoin-gold"}
      ]

      search_event_fixtures()
      |> Template.quick_replies(template_tile, replies)
    end
  end
end
