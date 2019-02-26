defmodule EctoChangesetTools.MixProject do
  use Mix.Project

  def project do
    [
      app: :ecto_changeset_tools,
      version: "0.1.0",
      elixir: "~> 1.7",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      docs: docs(),
      package: package()
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:dialyxir, "~> 0.5", only: [:dev], runtime: false},
      {:ecto, "~> 3.0"},
      {:excoveralls, "~> 0.4", only: [:test], runtime: false},
      {:ex_doc, "~> 0.19", only: [:dev], runtime: false}
    ]
  end

  defp docs do
    [
      name: "EctoChangeset Tools",
      source_url: "https://github.com/Kartstig/ecto_changeset_tools",
      homepage_url: "https://hexdocs.pm/ecto_changeset_tools",
      docs: [
        main: "EctoChangesetTools",
        logo: "https://github.com/Kartstig/ecto_changeset_tools/blob/master/logo.png?raw=true",
        extras: ["README.md"]
      ]
    ]
  end

  defp package do
    [
      name: "ecto_changeset_tools",
      licenses: ["MIT"],
      links: %{
        git: "https://github.com/Kartstig/ecto_changeset_tools"
      },
      maintainers: ["Herman Singh"],
      source_url: "https://github.com/Kartstig/ecto_changeset_tools",
      homepage_url: "https://hexdocs.pm/ecto_changeset_tools"
    ]
  end
end
