defmodule Spider.Repo.Migrations.CreateTraincs do
  use Ecto.Migration

  def change do
    create table(:traincs) do
      add :unique_number, :string
      add :role, :string

      timestamps()
    end

    create unique_index(:traincs, [:unique_number])
  end
end
