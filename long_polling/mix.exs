defmodule LongPolling.Mixfile do
  use Mix.Project

  def project do
    [app: :long_polling,
     version: "0.1.0",
     elixir: "~> 1.4",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps()]
  end

  def application do
    [extra_applications: [:logger, :cowboy],
     mod: {LongPolling.Application, []}]
  end

  defp deps do
    [
      {:cowboy, git: "https://github.com/ninenines/cowboy.git", tag: "2.0.0-pre.5"}
    ]
  end
end
