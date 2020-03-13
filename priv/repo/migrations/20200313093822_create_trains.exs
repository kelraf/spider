defmodule Spider.Repo.Migrations.CreateTrains do
  use Ecto.Migration

  def change do
    create table(:trains) do
      add :unique_number, :string

      timestamps()
    end

    create unique_index(:trains, [:unique_number])
  end
end
