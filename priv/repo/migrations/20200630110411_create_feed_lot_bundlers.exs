defmodule Spider.Repo.Migrations.CreateFeedLotBundlers do
  use Ecto.Migration

  def change do
    create table(:feed_lot_bundlers) do
      add :business_id, references(:businesses, on_delete: :delete_all)

      timestamps()
    end

  end
end
