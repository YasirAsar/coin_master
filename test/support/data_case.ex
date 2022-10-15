defmodule CoinMaster.DataCase do
  @moduledoc false

  use ExUnit.CaseTemplate

  using do
    quote do
      import CoinMaster.Facebook.EventFixtures
      import CoinMaster.Facebook.ProfileFixtures
      import CoinMaster.Facebook.CoinsFixtures
      import CoinMaster.CoinGecko.CoinGeckoFixtures

      import CoinMaster.DataCase

      require IEx
    end
  end
end
