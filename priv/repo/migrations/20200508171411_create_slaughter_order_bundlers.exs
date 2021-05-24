defmodule Spider.Repo.Migrations.CreateSlaughterOrderBundlers do
  use Ecto.Migration

  def change do
    create table(:slaughter_order_bundlers) do

      add :business_id, references(:businesses, on_delete: :delete_all)

      timestamps()
    end

  end
end
