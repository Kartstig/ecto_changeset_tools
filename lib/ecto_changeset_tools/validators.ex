defmodule EctoChangesetTools.Validators do
  @doc """
  Validate a phone number field
  """
  @spec validate_phone_field(Ecto.Changeset.t(), atom()) :: Ecto.Changeset.t()
  def validate_phone_field(changeset, field) do
    case Ecto.Changeset.get_change(changeset, field) do
      nil -> changeset
      "" -> changeset
      <<_phone_number::binary-size(10)>> -> changeset
      _ -> Ecto.Changeset.add_error(changeset, field, "Invalid phone number")
    end
  end
end