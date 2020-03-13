defmodule Spider.Repo.Migrations.CreateTrains do
  use Ecto.Migration

  def change do
    create table(:trains) do
      add :unique_number, :string
      add :role, :string

      add :user_id, references(:users, on_delete: :nothing)
      add :business_id, references(:businesses, on_delete: :delete_all)

      timestamps()
    end

    create unique_index(:trains, [:unique_number])
  end
end
