defmodule Spider.Repo.Migrations.CreateFlights do
  use Ecto.Migration

  def change do
    create table(:flights) do
      add :unique_number, :string
      add :role, :string

      add :user_id, references(:users, on_delete: :nothing)
      add :business_id, references(:businesses, on_delete: :delete_all)

      timestamps()
    end

    create unique_index(:flights, [:unique_number])
  end
end
