defmodule Spider.Repo.Migrations.CreateImageuploads do
  use Ecto.Migration

  def change do
    create table(:imageuploads) do
      add :image, :string

      timestamps()
    end

  end
end
