defmodule ExPlay.Protobuf do
  @moduledoc """
  Wrapper Module for encoding/decoding protobuf data.

  It's important that the npm module `protobufjs` is available to the
  project. Currently no Elixir/Erlang package supports Protobuf v2.
  """

  @protobuf_file Path.expand("../proto/googleplay.proto", __DIR__)
  @inspect_limit 10_000


  @doc "Decodes protobuf data from an HTTPResponse"
  def decode(%HTTPoison.Response{body: body}, type) do
    decode(body, type)
  end


  @doc "Decodes protobuf data according to the specified type"
  def decode(data, type) do
    binary_list = :binary.bin_to_list(data)

    {out, _exit} = System.cmd("node", ["-e", """
      var protobuf     = require('protobufjs');
      var builder      = protobuf.loadProtoFile('#{@protobuf_file}');
      var module       = builder.build('#{type}');

      var buffer       = new Buffer( #{ inspect(binary_list, limit: @inspect_limit) } );
      var decodedData  = module.decode(buffer);

      console.log(JSON.stringify(decodedData));
    """])

    Poison.decode!(out)
  end
end
