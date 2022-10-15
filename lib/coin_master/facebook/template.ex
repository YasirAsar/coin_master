defmodule CoinMaster.Facebook.Template do
  @moduledoc """
  This module has all template processing functions.
  """

  alias CoinMaster.Facebook.EventParser
  alias CoinMaster.Types

  @doc """
  Get started template
  """
  @spec get_started() :: Types.template()
  def get_started do
    %{"get_started" => %{"payload" => "get_started"}}
  end

  @doc """
  Return general text message template.
  """
  @spec text(Types.event(), String.t()) :: Types.template()
  def text(event, text) do
    message = %{"text" => text}

    template(event, message)
  end

  @doc """
  Return formatted quick reply template.
  """
  @spec quick_replies(Types.event(), String.t(), list({String.t(), String.t()})) ::
          Types.template()
  def quick_replies(event, template_title, replies) do
    message = %{
      "text" => template_title,
      "quick_replies" => replies(replies)
    }

    template(event, message)
  end

  defp template(event, message) do
    %{
      "message" => message,
      "recipient" => recipient(event)
    }
  end

  defp recipient(event) do
    %{"id" => EventParser.get_sender(event)["id"]}
  end

  defp replies(replies) do
    Enum.map(replies, fn {title, payload} ->
      %{
        "content_type" => "text",
        "title" => title,
        "payload" => payload
      }
    end)
  end
end
