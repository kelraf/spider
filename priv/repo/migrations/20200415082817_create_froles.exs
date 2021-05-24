defmodule Spider.Repo.Migrations.CreateFroles do
  use Ecto.Migration

  def change do
    create table(:froles) do
      add :capacity, :integer

      add :flight_id, references(:flights, on_delete: :delete_all)
      add :drole_id, references(:droles, on_delete: :delete_all)

      timestamps()
    end

  end
end
