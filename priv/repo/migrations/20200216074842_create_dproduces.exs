defmodule Spider.Repo.Migrations.CreateDproduces do
  use Ecto.Migration

  def change do
    create table(:dproduces) do
      
      add :referenced_animal, :string
      add :produce_name, :string
      add :units, :string

      timestamps()
    end

  end
end
