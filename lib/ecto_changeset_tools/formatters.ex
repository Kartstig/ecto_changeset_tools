defmodule EctoChangesetTools.Formatters do
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
