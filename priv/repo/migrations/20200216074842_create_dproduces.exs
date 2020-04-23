defmodule Spider.Repo.Migrations.CreateDproduces do
  use Ecto.Migration

  def change do
    create table(:dproduces) do
      
      add :reference, :string
      add :category, :string
      add :units, :string

      timestamps()
    end

  end
end
