ExPlay
======

> Google Play (Android Market) API in Elixir :computer:

(Ported from [`node-google-play`][gp-node])



## Installation

Add `explay` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [{:explay, "~> 0.1.2"}]
end
```

### Install JS Dependency

Right now, there isn't an erlang/elixir implementation of Google's Protobuf library
that can decode v2 data correctly, so we're relying on the npm module `protobufjs`.
In your project's root, run:

```bash
npm init
npm install protobufjs --save
```

or if you prefer [`yarn`][yarn]:

```bash
yarn add protobufjs
```



## Usage

There are a lot of modules, each handling their own relevant API calls, but you need
to be concerned with only two:

 - ExPlay.Account
 - ExPlay.Request


#### Authentication

To interact with the Google Play API and get back data, you need a valid and authenticated
Google account (with email, password and device id).

```elixir
# Save this account object to later use in API requests

account = %ExPlay.Account{email: "john@gmail.com", password: "12345678", device_id: "XXXXXXXX"}
account = ExPlay.Account.authenticate!(account)
```

#### Get App Details

```elixir
{:ok, app} = ExPlay.Request.package_details(account, "com.facebook.katana")

app.title
# => "Facebook"

app.descriptionHtml
# => "Keeping up with friends is faster than ever..."

app.details.appDetails.numDownloads
# => "1,000,000,000+ downloads"

app.details.appDetails.versionCode
# => 41212272

# And lots of other stuff. Use Map.keys(app) to get an idea of the response.
```

#### Get App Delivery Data

You can get an app's delivery data using `ExPlay.Request.package_download_info/2`.
It will return a map with a downloadable APK url and authorization cookies which
you can pass to any HTTP client to download the APK (Even `wget` or `curl`).

Note: The `package` here can be the app's bundle identifier string or a
`{bundle, version}` tuple.

```elixir
{:ok, info} = ExPlay.Request.package_download_info(account, "com.facebook.katana")

info.downloadUrl
# => "https://play.googlezip.net/market/download/Download?packageName=com.facebook.katana&versionCode=41212272&ssl..."

info.downloadAuthCookie
# => [%{"name" => "MarketDA", "value" => "09919279757374609811"}]
```

#### Download APK

Alternatively, you can let `ExPlay` download the app for you. Specify the package
you want to download and a (writable) path where you'd like to save it.

Note: The `package` here can be the app's bundle identifier string or a
`{bundle, version}` tuple.

```elixir
ExPlay.Request.download!(account, "com.facebook.katana", "/tmp/facebook.apk")
# => :ok
```



## Roadmap

 - [ ] Write missing Tests
 - [x] Write Documentation
 - [ ] Update documentation with more information and examples
 - [ ] Implement pure Erlang/Elixir Protobuf v2 solution for decoding data
 - [ ] Cover all API calls
    - [x] Authentication
    - [x] Package Details
    - [ ] Bulk Package Details
    - [ ] Search Apps
    - [ ] Related Apps
    - [ ] Categories
    - [ ] App Reviews
    - [x] Download App
    - [ ] Download App Data



## Contributing

 - [Fork][github-fork], Enhance, Send PR
 - Lock issues with any bugs or feature requests
 - Implement something from Roadmap
 - Spread the word



## License

This package is available as open source under the terms of the [MIT License][license].



  [license]:          http://opensource.org/licenses/MIT
  [github-fork]:      https://github.com/sheharyarn/ex_utils/fork

  [yarn]:             https://github.com/yarnpkg/yarn
  [gp-node]:          https://github.com/dweinstein/node-google-play


