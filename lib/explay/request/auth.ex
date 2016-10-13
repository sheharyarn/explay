defmodule ExPlay.Request.Auth do
  use ExPlay.Request.Base

  @moduledoc """
  Wrapper module to handle authentication for Google Play user
  """


  @doc "Authenticates, returning a new Account instance with auth_token set"
  def authenticate!(account) do
    {:ok, token} =
      account
      |> make_auth_request!
      |> parse_response

    %{ account | auth_token: token }
  end


  @doc "Make Authentication request for an Account instance"
  def make_auth_request!(account) do
    post!(@url.auth, auth_body(account), auth_headers)
  end


  @doc "Parses Authentication request response for useful information"
  def parse_response(%HTTPoison.Response{body: body}) do
    cond do
      Regex.match?(@regex.auth.success, body) ->
        [_, token] = Regex.run(@regex.auth.success, body)
        {:ok, token}

      Regex.match?(@regex.auth.error, body) ->
        [_, error_code] = Regex.run(@regex.auth.error, body)
        {:error, [error_code, error_message(error_code)]}

      true ->
        {:error, ["AuthUnavailable", "Auth Code unavailable for some reason"]}
    end
  end


  @doc "Keyword List of required authentication headers"
  def auth_headers do
    [{"Content-type", @defaults.content_type}]
  end


  @doc "Prepares Keyword List of required body params for User authentication"
  def auth_body(account) do
    [
      { "Email",             account.email             },
      { "Passwd",            account.password          },
      { "androidId",         account.device_id         },

      { "source",            @defaults.source          },
      { "app",               @defaults.vending         },
      { "lang",              @defaults.language        },
      { "service",           @defaults.service         },
      { "sdk_version",       @defaults.sdk_version     },
      { "accountType",       @defaults.account_type    },
      { "has_permission",    @defaults.has_permission  },
      { "device_country",    @defaults.country_code    },
      { "operatorCountry",   @defaults.country_code    }
    ]
  end


  # Private Methods

  defp error_message(code) do
    case code do
      "BadAuthentication"  -> "Incorrect username or password."
      "NotVerified"        -> "The account email address has not been verified. You need to access your Google account directly to resolve the issue before logging in here."
      "TermsNotAgreed"     -> "You have not yet agreed to Google's terms, acccess your Google account directly to resolve the issue before logging in using here."
      "CaptchaRequired"    -> "A CAPTCHA is required. (not supported, try logging in another tab)"
      "Unknown"            -> "Unknown or unspecified error; the request contained invalid input or was malformed."
      "AccountDeleted"     -> "The user account has been deleted."
      "AccountDisabled"    -> "The user account has been disabled."
      "ServiceDisabled"    -> "Your access to the specified service has been disabled. (The user account may still be valid.)"
      "ServiceUnavailable" -> "The service is not available; try again later."
      _                    -> "Unknown Error"
    end
  end
end
