defmodule Spider.Repo.Migrations.CreateVessles do
  use Ecto.Migration

  def change do
    create table(:vessles) do
      add :unique_number, :string
      add :role, :string

      timestamps()
    end

    create unique_index(:vessles, [:unique_number])
  end
end
