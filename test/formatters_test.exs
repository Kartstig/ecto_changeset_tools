defmodule FormattersTest do
  use ExUnit.Case

  setup do
    defmodule TestSchema do
      use Ecto.Schema

      schema "test" do
        field(:stringy, :string)
        field(:booly, :boolean)
        field(:inty, :integer)
        field(:timey, :utc_datetime)
      end
    end

    {:ok, schema: TestSchema}
  end

  test "downcase_field/2", %{schema: schema} do
    result =
      Ecto.Changeset.change(struct(schema), %{stringy: "SOMETHING ELSE ALL CAPS 1234!@"})
      |> EctoChangesetTools.Formatters.downcase_field(:stringy)

    assert %{stringy: "something else all caps 1234!@"} = result.changes
  end

  test "downcase_fields/2", %{schema: schema} do
    result =
      Ecto.Changeset.change(struct(schema), %{stringy: "SOMETHING ALL CAPS"})
      |> EctoChangesetTools.Formatters.downcase_fields([:stringy])

    assert %{stringy: "something all caps"} = result.changes
  end

  test "generate_uuid_field/2", %{schema: schema} do
    result =
      Ecto.Changeset.change(struct(schema), %{stringy: ""})
      |> EctoChangesetTools.Formatters.generate_uuid_field(:stringy)

    field = Map.get(result.changes, :stringy)

    assert "" != field
    assert 36 == String.length(field)
  end

  test "sanitize_phone_field/2", %{schema: schema} do
    result =
      Ecto.Changeset.change(struct(schema), %{stringy: "(123)456-7890!!!,,..? --"})
      |> EctoChangesetTools.Formatters.sanitize_phone_field(:stringy)

    field = Map.get(result.changes, :stringy)

    assert "1234567890" == field
    assert 10 == String.length(field)
  end
end
