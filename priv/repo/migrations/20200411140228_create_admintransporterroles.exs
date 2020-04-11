defmodule Spider.Repo.Migrations.CreateAdmintransporterroles do
  use Ecto.Migration

  def change do
    create table(:admintransporterroles) do
      add :role, :string
      
      timestamps()
    end

  end
end
