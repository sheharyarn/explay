defmodule ExPlay.Mixfile do
  use Mix.Project

  def project do
    [app: :explay,
     version: "0.1.0",
     elixir: "~> 1.3",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps()]
  end

  def application do
    [applications: [:logger, :httpoison]]
  end

  defp deps do
    [
      {:poison,     "~> 3.0"   },
      {:httpoison,  "~> 0.8.0" },
      {:ex_utils,   git: "https://github.com/sheharyarn/ex_utils.git"}
    ]
  end
end
