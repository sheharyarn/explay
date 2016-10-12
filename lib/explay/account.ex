defmodule ExPlay.Account do
  defstruct [:email, :password, :auth_token]

  @moduledoc """
  Struct representation of a Google Play user account
  """

  @doc "Checks if Account has :auth_token present"
  def authenticated?(account) do
    is_nil(account.auth_token)
  end
end
