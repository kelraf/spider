defmodule Spider.Repo.Migrations.CreateBusinessAssets do
  use Ecto.Migration

  def change do
    create table(:business_assets) do
      add :asset_name, :string

      add :business_id, references(:businesses, on_delete: :delete_all)

      timestamps()
    end

  end
end
