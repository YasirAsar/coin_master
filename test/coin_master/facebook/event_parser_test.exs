defmodule CoinMaster.Facebook.EventParserTest do
  use CoinMaster.DataCase

  import Mox

  setup :verify_on_exit!

  @facebook_client Application.compile_env!(:coin_master, :facebook_client)

  alias CoinMaster.Facebook.EventParser

  describe "get_recipient/1" do
    test "return valid recipient" do
      get_started_event_fixtures()
      |> EventParser.get_recipient()
      |> then(fn reipient ->
        reipient == %{"id" => "1234567"}
      end)
      |> assert()
    end
  end

  describe "get_message/1" do
    test "return message" do
      search_event_fixtures()
      |> EventParser.get_message()
      |> then(fn message ->
        message == %{
          "mid" => "1234",
          "nlp" => %{
            "detected_locales" => [%{"confidence" => 0.7895, "locale" => "en_XX"}],
            "entities" => %{},
            "intents" => [],
            "traits" => %{
              "wit$sentiment" => [
                %{"confidence" => 0.5621, "id" => "12345", "value" => "neutral"}
              ]
            }
          },
          "text" => "bitcoin"
        }
      end)
      |> assert()
    end
  end

  describe "get_greetings_entity/1" do
    test "if wi$greetings nlp exist in event, return it's entity" do
      greetings_event_fixtues()
      |> EventParser.get_greetings_entity()
      |> then(fn greetings ->
        greetings == %{"confidence" => 0.9999, "id" => "12345", "value" => "true"}
      end)
      |> assert()
    end

    test "if wi$greetings not found in the event, return false" do
      get_started_event_fixtures()
      |> EventParser.get_greetings_entity()
      |> refute()
    end
  end

  describe "get_profile/1" do
    test "if facebook client return requested format, return profile" do
      expect(@facebook_client, :get_profile, fn _args ->
        {:ok, profile_fixtures()}
      end)

      greetings_event_fixtues()
      |> EventParser.get_profile()
      |> then(fn profile ->
        profile == profile_fixtures()
      end)
      |> assert()
    end

    test "if facebook client return error, return empty map" do
      expect(@facebook_client, :get_profile, fn _args -> :error end)

      greetings_event_fixtues()
      |> EventParser.get_profile()
      |> then(fn profile ->
        profile == %{}
      end)
      |> assert()
    end
  end
end
