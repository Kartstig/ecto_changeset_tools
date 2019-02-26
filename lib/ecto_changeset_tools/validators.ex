defmodule EctoChangesetTools.Validators do
  @moduledoc """
  Implement these in your changeset stream:

      defmodule User do
        use Ecto.Schema
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
          |> validate_phone_field(:phone_number)
          |> validate_required([:email])
          |> unique_constraint(:email)
        end
      end
  """

  @doc """
  Validate a phone number field

  When invalid, adds `Invalid phone number` to changeset errors
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
