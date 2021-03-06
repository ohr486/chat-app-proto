defmodule Chat.Mixfile do
  use Mix.Project

  def project do
    [app: :chat,
     version: "0.1.0",
     elixir: "~> 1.4",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps()]
  end

  def application do
    [extra_applications: [:logger],
     mod: {Chat.Application, [:cowboy]}]
  end

  defp deps do
    [
      {:cowboy, git: "https://github.com/ninenines/cowboy.git", tag: "2.0.0-pre.7"}
    ]
  end
end
