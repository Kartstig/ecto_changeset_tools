defmodule ValidatorsTest do
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

  test "validate_phone_field/2 returns valid for valid numbers", %{schema: schema} do
    result =
      Ecto.Changeset.change(struct(schema), %{stringy: "1234567890"})
      |> EctoChangesetTools.Validators.validate_phone_field(:stringy)

    assert true == result.valid?
  end

  test "validate_phone_field/2 returns invalid for numbers too short", %{schema: schema} do
    result =
      Ecto.Changeset.change(struct(schema), %{stringy: "123"})
      |> EctoChangesetTools.Validators.validate_phone_field(:stringy)

    assert false == result.valid?
  end

  test "validate_phone_field/2 returns invalid for numbers too long", %{schema: schema} do
    result =
      Ecto.Changeset.change(struct(schema), %{stringy: "12345678901234"})
      |> EctoChangesetTools.Validators.validate_phone_field(:stringy)

    assert false == result.valid?
  end

  test "validate_phone_field/2 returns valid for nil fields", %{schema: schema} do
    result =
      Ecto.Changeset.change(struct(schema), %{stringy: nil})
      |> EctoChangesetTools.Validators.validate_phone_field(:stringy)

    assert true == result.valid?
  end

  test "validate_phone_field/2 returns valid for empty fields", %{schema: schema} do
    result =
      Ecto.Changeset.change(struct(schema), %{stringy: ""})
      |> EctoChangesetTools.Validators.validate_phone_field(:stringy)

    assert true == result.valid?
  end
end
