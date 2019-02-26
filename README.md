# Ecto Changeset Tools
> Don't go schema-writing without em

[![CircleCI](https://circleci.com/gh/Kartstig/ecto_changeset_tools/tree/master.svg?style=svg)](https://circleci.com/gh/Kartstig/ecto_changeset_tools/tree/master) [![codecov](https://codecov.io/gh/Kartstig/ecto_changeset_tools/branch/master/graph/badge.svg)](https://codecov.io/gh/Kartstig/ecto_changeset_tools)

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `ecto_changeset_tools` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:ecto_changeset_tools, "~> 1.0.0"}
  ]
end
```

## Usage
EctoChangesetTools provides some more commonly used abstractions for updating and validating fields
for modules that implement [Ecto.Schema](https://hexdocs.pm/ecto/Ecto.Schema.html#t:t/0), but more specifically, modules that utilitize [Ecto.Changeset.change/2](https://hexdocs.pm/ecto/Ecto.Changeset.html#change/2).

All functions in this module are designed to be pipe friendly. That means you can easily incorporate
them into your schemas:
```elixir
defmodule User do
  use Ecto.Schema
  import EctoChangesetTools.Formatters
  import EctoChangesetTools.Validators

  @spec changeset(__MODULE__.t(), map()) :: Ecto.Changeset.t()
  def changeset(%__MODULE__{} = user, attrs) do
    user
    |> cast(attrs, [
      :email,
      :first_name,
      :last_name,
      :phone_number
    ])
    |> downcase_fields([:email, :first_name, :last_name])
    |> sanitize_phone_field(:phone_number)
    |> validate_phone_field(:phone_number)
    |> validate_required([:email])
    |> unique_constraint(:email)
  end
end
```
Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/ecto_changeset_tools](https://hexdocs.pm/ecto_changeset_tools).

