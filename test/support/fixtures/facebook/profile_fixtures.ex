defmodule CoinMaster.Facebook.ProfileFixtures do
  @moduledoc false

  def profile_fixtures do
    %{
      "first_name" => "first_name",
      "id" => "123",
      "last_name" => "last_name",
      "profile_pic" => "https://platform-lookaside.fbsbx.com/platform/profilepic/"
    }
  end

  def welcome_message_template_fixtures do
    %{
      "message" => %{"text" => "Hello first_name :)\nWelcome to Crypto Gecko!\n"},
      "recipient" => %{"id" => "1234567"}
    }
  end

  def something_went_wrong_template_fixtures do
    %{
      "message" => %{
        "text" => "Something went wrong. Our Engineers are working on it."
      },
      "recipient" => %{"id" => "1234567"}
    }
  end

  def verify_webhook_token_valid_params_fixtures do
    %{
      "hub.challenge" => "123",
      "hub.mode" => "subscribe",
      "hub.verify_token" => "secret"
    }
  end

  def verify_webhook_token_invalid_params_fixtures do
    %{
      "hub.challenge" => "123",
      "hub.mode" => "unsubscribe",
      "hub.verify_token" => "hello"
    }
  end
end
