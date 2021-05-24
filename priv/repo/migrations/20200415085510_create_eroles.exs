defmodule Spider.Repo.Migrations.CreateEroles do
  use Ecto.Migration

  def change do
    create table(:eroles) do
      add :capacity, :integer

      add :vessle_id, references(:vessles, on_delete: :delete_all)
      add :drole_id, references(:droles, on_delete: :delete_all)

      timestamps()
    end

  end
end
