defmodule ExPlay.Asset do
  defstruct [:url, :cookies, :signature, :size, :path]

  @moduledoc """
  Struct wrapper for Google Play downloadables (APKs for now)
  """


  @doc "Converts a Package Download Info map object into an Asset Struct"
  def to_asset(info) do
    %ExPlay.Asset{
      url:        info.downloadUrl,
      size:       info.downloadSize,
      signature:  info.signature,

      cookies:    Enum.reduce(info.downloadAuthCookie, "", &cookie_reducer/2)
    }
  end


  @doc "Checks if Asset has been downloaded"
  def downloaded?(%ExPlay.Asset{path: path}) do
    !!(path)
  end


  @doc "Downloads Google Play asset to disk"
  def download!(%ExPlay.Asset{} = asset, path) do
    %HTTPoison.Response{status_code: 200, body: binary} =
      HTTPoison.get!(asset.url, %{}, hackney: [cookie: [asset.cookies]])

    path = Path.expand(path)
    File.mkdir_p!(Path.dirname(path))
    File.write!(path, binary)

    %{ asset | path: path }
  end


  @doc "Fetches APK downloads details using authenticated account and then downloads it to disk"
  def download!(account, {package, version}, path) do
    {:ok, info} = ExPlay.Request.API.package_download_info(account, package, version)

    info
    |> to_asset
    |> download!(path)
  end

  def download!(account, package, path) do
    download!(account, {package, nil}, path)
  end


  # Private Methods

  defp cookie_reducer(%{"name" => name, "value" => value}, cookie) do
    cookie <> "#{name}=#{value}; "
  end

end
