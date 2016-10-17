defmodule ExPlay.Request.API do
  use ExPlay.Request.Base

  @moduledoc """
  Google Play API call handler methods
  """


  @doc """
  Returns all details about a Google Play APK package,
  needs an authorized account object
  """
  def package_details(account, package) do
    get!("details", [{"doc", package}], api_headers(account).get)
  end



  @doc "Generates API specific URLs from specified paths"
  def process_url(path) do
    @url.api <> path
  end


  @doc "API Specific GET requests"
  def get!(path, params, headers),  do: super(process_url(path), params, headers)

  @doc "API Specific POST requests"
  def post!(path, params, headers), do: super(process_url(path), params, headers)


  @doc "Prepare headers for api request"
  def api_headers(account) do
    common = [
      { "Authorization",                 "GoogleLogin auth=#{account.auth_token}"  },
      { "X-DFE-Device-Id",               account.device_id                         },

      { "User-Agent",                    @user_agent.api                           },
      { "Accept-Language",               @defaults.language                        },
      { "Host",                          @defaults.host                            },

      { "X-DFE-Client-Id",               @defaults.xdfe.client_id                  },
      { "X-DFE-SmallestScreenWidthDp",   @defaults.xdfe.screen_width               },
      { "X-DFE-Filter-Level",            @defaults.xdfe.filter_level               },
      { "X-DFE-No-Prefetch",             @defaults.xdfe.no_prefetch                },
      { "X-DFE-Enabled-Experiments",     @defaults.xdfe.enabled_experiments        },
      { "X-DFE-Unsupported-Experiments", @defaults.xdfe.unsupported_experiments    }
    ]

    %{
      get:  common,
      post: common ++ [{"Content-type",  @defaults.content_type}]
    }
  end
end
