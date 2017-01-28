defmodule ExPlay.Request.Base do
  @moduledoc """
  Base Module with default options, urls and configurations for
  Google Play authentication and other API requests
  """


  @doc "GET request wrapper"
  def get!(url, params, headers \\ []) do
    HTTPoison.get!(url <> "?" <> encode_args(params), headers)
  end


  @doc "POST request wrapper"
  def post!(url, params, headers \\ []) do
    HTTPoison.post!(url, encode_args(params), headers)
  end


  @doc "Encodes body args into k=v format"
  def encode_args(args) do
    URI.encode_query(args)
  end



  @doc false
  defmacro __using__(_) do
    quote do

      @url %{
        api:  "https://android.clients.google.com/fdfe/",
        auth: "https://android.clients.google.com/auth"
      }

      @regex %{
        auth: %{
          error:   ~r/Error=(\w+)/,
          success: ~r/Auth=([a-z0-9=_\-\.]+)/i
        }
      }

      @user_agent %{
        downloader:
          "AndroidDownloadManager/6.0.1 (Linux; U; Android 6.0.1; Nexus 5X Build/MHC19Q)",
        api:
          "Android-Finsky/6.8.44.F-all%20%5B0%5D%203087104 "                  <>
          "(api=3,versionCode=80684400,sdk=23,device=bullhead,"               <>
          "hardware=bullhead,product=bullhead,platformVersionRelease=6.0.1,"  <>
          "model=Nexus%205X,buildId=MHC19Q,isWideScreen=0)"
      }

      @defaults %{
        language:        "en_US",
        has_permission:  "1",
        sdk_version:     "23",
        country_code:    "us",
        vending:         "com.android.vending",
        account_type:    "HOSTED_OR_GOOGLE",
        host:            "android.clients.google.com",
        source:          "android",
        service:         "androidmarket",
        content_type:    "application/x-www-form-urlencoded; charset=UTF-8",
        cache_interval:  30_000,

        xdfe: %{
          no_prefetch:     true,
          screen_width:    "320",
          filter_level:    "3",
          client_id:       "am-android-google",

          enabled_experiments: Enum.join([
            "cl:billing.select_add_instrument_by_default"
          ], ","),

          unsupported_experiments: Enum.join([
            "nocache:billing.use_charging_poller",
            "market_emails", "buyer_currency", "prod_baseline",
            "checkin.set_asset_paid_app_field", "shekel_test", "content_ratings",
            "buyer_currency_in_app", "nocache:encrypted_apk", "recent_changes"
          ], ",")
        }

      }


      defdelegate  get!(url, params, headers \\ []),  to: ExPlay.Request.Base
      defdelegate post!(url, params, headers \\ []),  to: ExPlay.Request.Base
      defdelegate encode_args(args),                  to: ExPlay.Request.Base

      defoverridable get!: 3, post!: 3
    end
  end
end
