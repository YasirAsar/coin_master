defmodule CoinMaster.HTTPClient do
  @moduledoc """
  This module works as bridge between application and HTTPoison.
  """

  @callback get(String.t()) :: {:ok, map()} | {:error, any()}
  @spec get(String.t()) :: {:ok, map()} | {:error, any()}
  def get(endpoint) do
    endpoint
    |> HTTPoison.get()
    |> handle_response()
  end

  @callback post(String.t(), map()) :: {:ok, map()} | {:error, any()}
  @spec post(String.t(), map()) :: {:ok, map()} | {:error, any()}
  def post(endpoint, body) do
    headers = [{"content-type", "application/json"}]
    body = Jason.encode!(body)

    endpoint
    |> HTTPoison.post(body, headers)
    |> handle_response()
  end

  defp handle_response({:ok, %{status_code: 200} = response}),
    do: {:ok, Jason.decode!(response.body)}

  defp handle_response(error), do: error
end
