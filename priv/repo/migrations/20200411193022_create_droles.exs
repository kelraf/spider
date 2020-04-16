defmodule Spider.Repo.Migrations.CreateDroles do
  use Ecto.Migration

  def change do
    create table(:droles) do
      
      add :role, :string
      add :capacity_units, :string

      timestamps()
    end

  end
end
