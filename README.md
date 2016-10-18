ExPlay
======

> Google Play (Android Market) API in Elixir :computer:

(Ported from [`node-google-play`][gp-node])



## Installation

Add `explay` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [{:explay, ">= 0.0.0"}]
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
    - [ ] Download App
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


