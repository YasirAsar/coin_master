defmodule CoinMaster.Facebook.ProfileTest do
  use CoinMaster.DataCase

  import Mox

  setup :verify_on_exit!

  @facebook_client Application.compile_env!(:coin_master, :facebook_client)

  alias CoinMaster.Facebook.Profile

  describe "welcome_message/1" do
    test "return welcome message template" do
      expect(@facebook_client, :get_profile, fn _args ->
        {:ok, profile_fixtures()}
      end)

      received_template =
        get_started_event_fixtures()
        |> Profile.welcome_message()

      assert received_template == [welcome_message_template_fixtures()]
    end
  end

  describe "something_went_wrong/1" do
    test "return something went wrong text template" do
      received_template =
        get_started_event_fixtures()
        |> Profile.something_went_wrong()

      assert received_template == [something_went_wrong_template_fixtures()]
    end
  end
end
