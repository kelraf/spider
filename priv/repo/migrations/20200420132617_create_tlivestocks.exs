defmodule Spider.Repo.Migrations.CreateTlivestocks do
  use Ecto.Migration

  def change do
    create table(:tlivestocks) do
      add :quantity, :integer
      add :livestock_id, references(:livestocks, on_delete: :delete_all)
      timestamps()
    end

  end
end
