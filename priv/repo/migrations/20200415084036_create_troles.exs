defmodule Spider.Repo.Migrations.CreateTroles do
  use Ecto.Migration

  def change do
    create table(:troles) do
      add :capacity, :integer

      add :train_id, references(:trains, on_delete: :delete_all)
      add :drole_id, references(:droles, on_delete: :delete_all)

      timestamps()
    end

  end
end
