defmodule CoinMaster.Facebook.FacebookClientTest do
  use CoinMaster.DataCase

  import ExUnit.CaptureLog
  import Mox

  setup :verify_on_exit!

  alias CoinMaster.Facebook.EventParser
  alias CoinMaster.Facebook.FacebookClient
  alias CoinMaster.Facebook.Template

  @http_client Application.compile_env!(:coin_master, :http_client)

  describe "send_message/1" do
    test "if message send successfully, return success map" do
      template = welcome_message_template_fixtures()

      expect(@http_client, :post, fn endpoint, body ->
        assert endpoint =~ "https://graph.facebook.com/v15.0/me/messages/?access_token="
        assert body == template

        {:ok, %{}}
      end)

      template
      |> FacebookClient.send_message()
      |> then(fn response ->
        response == {:ok, %{}}
      end)
      |> assert()
    end

    test "if message send failed, return error" do
      expect(@http_client, :post, fn _endpoint, _body ->
        {:error, "failed"}
      end)

      {response, log} =
        with_log(fn ->
          welcome_message_template_fixtures()
          |> FacebookClient.send_message()
        end)

      assert response == :error
      assert log =~ "Error in sending message"
    end
  end

  describe "set_message_profile/1" do
    test "if profile set successfully, return success map" do
      template = Template.get_started()

      expect(@http_client, :post, fn endpoint, body ->
        assert endpoint =~ "https://graph.facebook.com/v15.0/me/messenger_profile/?access_token="
        assert body == template

        {:ok, %{}}
      end)

      template
      |> FacebookClient.set_message_profile()
      |> then(fn response ->
        response == {:ok, %{}}
      end)
      |> assert()
    end

    test "if profile setting failed, return error" do
      expect(@http_client, :post, fn _endpoint, _body ->
        {:error, "failed"}
      end)

      {response, log} =
        with_log(fn ->
          Template.get_started()
          |> FacebookClient.set_message_profile()
        end)

      assert response == :error
      assert log =~ "Error in setting profile"
    end
  end

  describe "get_profile/1" do
    test "got the profile successfully" do
      profile = profile_fixtures()

      expect(@http_client, :get, fn endpoint ->
        assert endpoint =~ "https://graph.facebook.com/v15.0/1234567/?access_token="

        {:ok, profile}
      end)

      get_started_event_fixtures()
      |> EventParser.get_sender()
      |> FacebookClient.get_profile()
      |> then(fn {:ok, received_profile} ->
        received_profile == profile
      end)
      |> assert()
    end

    test "if not able get the profile, return error" do
      expect(@http_client, :get, fn _endpoint ->
        {:error, "failed"}
      end)

      {response, log} =
        with_log(fn ->
          get_started_event_fixtures()
          |> EventParser.get_sender()
          |> FacebookClient.get_profile()
        end)

      assert response == :error
      assert log =~ "Error in getting profile"
    end
  end
end
