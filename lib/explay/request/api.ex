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
  end



  @doc "Generates API specific URLs from specified paths"
  def process_url(path) do
    @url.api <> path
  end


  @doc "API Specific GET requests"
  def get!(path, params, headers),  do: super(process_url(path), params, headers)

  @doc "API Specific POST requests"
  def post!(path, params, headers), do: super(process_url(path), params, headers)

end
