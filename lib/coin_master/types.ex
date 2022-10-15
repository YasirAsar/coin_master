defmodule CoinMaster.Types do
  @moduledoc false

  @typedoc "HTTPoison response"
  @type http_response() :: {:ok, map()} | :error

  @typedoc "Facebook event messaging"
  @type messaging() :: map()

  @typedoc "Facebook event"
  @type event() :: map()

  @typedoc "Templates which send to sender"
  @type templates() :: list(template())

  @typedoc "Template which send to sender"
  @type template() :: map()
end
