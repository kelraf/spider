defmodule Spider.Repo.Migrations.CreateVroles do
  use Ecto.Migration

  def change do
    create table(:vroles) do

      add :drole_id, references(:droles, on_delete: :nothing)
      add :vehicle_id, references(:vehicles, on_delete: :delete_all)

      timestamps()
    end

  end
end
