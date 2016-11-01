defmodule Rumbl.Repo.Migrations.CreateAttachment do
  use Ecto.Migration

  def change do
    create table(:attachments) do
      add :name, :string
      add :file, :string

      timestamps()
    end

  end
end
