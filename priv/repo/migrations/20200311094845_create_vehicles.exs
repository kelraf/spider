defmodule Spider.Repo.Migrations.CreateVehicles do
  use Ecto.Migration

  def change do
    create table(:vehicles) do
      add :registration_number, :string
      add :role, :string

      timestamps()
    end

    create unique_index(:vehicles, [:registration_number])
  end
end
