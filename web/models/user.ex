defmodule Rumbl.User do
  use Rumbl.Web, :model
  use Arc.Ecto.Schema

  schema "users" do
    field :name, :string
    field :username, :string
    field :password, :string, virtual: true
    field :password_hash, :string
    field :avatar, Rumbl.Avatar.Type

    has_many :videos, Rumbl.Video
    has_many :annotations, Rumbl.Annotation
    has_many :articles, Rumbl.Article

    timestamps
  end

  def changeset(model, params \\ :invalid) do
    model
    |> cast(params, ~w(name username), [])
    |> cast_attachments(params, [:avatar])
    |> validate_length(:username, min: 1, max: 20)
    |> unique_constraint(:username)
  end

  def registration_changeset(model, params) do
    model
    |> changeset(params)
    |> cast(params, ~w(password), [])
    |> validate_length(:password, min: 6, max: 100)
    |> put_pass_hash()
  end

  # Create hashed passwords for all users:
  #
  # for u <- Repo.all(User) do
  #   Repo.update!(User.registration_changeset(u, %{password: u.password || "temppass"}))
  # end
  defp put_pass_hash(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{password: pass}} ->
        put_change(changeset, :password_hash, Comeonin.Bcrypt.hashpwsalt(pass))
      _ ->
        changeset
    end
  end
end
