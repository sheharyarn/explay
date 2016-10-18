defmodule ExPlay.Account do
  defstruct [:email, :password, :device_id, :auth_token]

  @moduledoc """
  Struct representation of a Google Play user account
  """

  @doc "Checks if Account has :auth_token present"
  def authenticated?(account) do
    !!(account.auth_token)
  end


  @doc "Makes sure account is authenticated otherwise raises error"
  def verify_authenticated!(account) do
    case authenticated?(account) do
      true  -> true
      false -> raise "Account not authenticated!"
    end
  end


  defdelegate authenticate(account),  to: ExPlay.Request.Auth
  defdelegate authenticate!(account), to: ExPlay.Request.Auth
end
