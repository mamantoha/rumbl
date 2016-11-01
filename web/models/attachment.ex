defmodule Rumbl.Attachment do
  use Rumbl.Web, :model
  use Arc.Ecto.Schema

  schema "attachments" do
    field :name, :string
    field :file, Rumbl.Image.Type

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name])
    |> cast_attachments(params, [:file])
    |> validate_required([:file])
  end
end
