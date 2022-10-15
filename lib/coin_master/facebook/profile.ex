defmodule CoinMaster.Facebook.Profile do
  @moduledoc """
  This module has facebook page message templates and function for setting get_started.
  """

  alias CoinMaster.Facebook.EventParser
  alias CoinMaster.Facebook.FacebookClient
  alias CoinMaster.Facebook.Template

  alias CoinMaster.Types

  @doc """
  Set get_started in facebook page messenger chat.
  """
  @spec set_get_started() :: Types.http_response()
  def set_get_started do
    Template.get_started()
    |> FacebookClient.set_message_profile()
  end

  @doc """
  Return welcome message template.
  """
  @spec welcome_message(Types.event()) :: Types.templates()
  def welcome_message(event) do
    first_name =
      event
      |> EventParser.get_profile()
      |> Map.get("first_name", "")

    message = """
    Hello #{first_name} :)
    Welcome to Crypto Gecko!
    """

    [Template.text(event, message)]
  end

  @doc """
  Return something went wrong template.
  """
  @spec something_went_wrong(Types.event()) :: Types.templates()
  def something_went_wrong(event) do
    [Template.text(event, "Something went wrong. Our Engineers are working on it.")]
  end
end
