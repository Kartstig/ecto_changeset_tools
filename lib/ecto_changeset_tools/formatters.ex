defmodule EctoChangesetTools.Formatters do
  @moduledoc """
  Implement these in your changeset steam.

      defmodule User do
        use Ecto.Schema
        import EctoChangesetTools.Formatters

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
          |> validate_required([:email])
          |> unique_constraint(:email)
        end
      end
  """

  @doc """
  Format a string field to be lowercase
  """
  @spec downcase_field(Ecto.Changeset.t(), atom()) :: Ecto.Changeset.t()
  def downcase_field(changeset, field) do
    case Ecto.Changeset.get_change(changeset, field) do
      nil -> changeset
      value -> Ecto.Changeset.put_change(changeset, field, String.downcase(value))
    end
  end

  @doc """
  Format a list of string fields to be lowercase
  """
  @spec downcase_fields(Ecto.Changeset.t(), list(atom())) :: Ecto.Changeset.t()
  def downcase_fields(changeset, []), do: changeset

  def downcase_fields(changeset, [field | remainder]) do
    downcase_fields(downcase_field(changeset, field), remainder)
  end

  @doc """
  Use Ecto.UUID.generate() to update a field
  """
  @spec generate_uuid_field(Ecto.Changeset.t(), atom()) :: Ecto.Changeset.t()
  def generate_uuid_field(changeset, field) do
    Ecto.Changeset.put_change(changeset, field, Ecto.UUID.generate())
  end

  @doc """
  Only accept digits on phone number
  """
  @spec sanitize_phone_field(Ecto.Changeset.t(), atom()) :: Ecto.Changeset.t()
  def sanitize_phone_field(changeset, field) do
    case Ecto.Changeset.get_change(changeset, field) do
      nil -> changeset
      value -> Ecto.Changeset.put_change(changeset, field, Regex.replace(~r/[^\d]/, value, ""))
    end
  end
end
