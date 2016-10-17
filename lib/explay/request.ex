defmodule ExPlay.Request do
  @moduledoc """
  Wrapper methods around Google Play API Calls
  """

  defdelegate authenticate(account),  to: ExPlay.Request.Auth
  defdelegate authenticate!(account), to: ExPlay.Request.Auth
end
