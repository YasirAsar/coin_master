defmodule CoinMaster.Facebook.SetGetStarted do
  @moduledoc """
  Task which executed on application start.

  Set the get_started in facebook page messenger.
  """

  use Task

  alias CoinMaster.Facebook.Profile

  def start_link(arg) do
    Task.start_link(__MODULE__, :run, [arg])
  end

  def run(_arg) do
    Profile.set_get_started()
  end
end
