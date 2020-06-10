defmodule Spider.Repo.Migrations.CreateExportZoneBundler do
  use Ecto.Migration

  def change do
    create table(:export_zone_bundler) do
      add :capacity, :integer
      add :size, :string

      add :business_id, references(:businesses, on_delete: :delete_all)

      timestamps()
    end

  end
end
