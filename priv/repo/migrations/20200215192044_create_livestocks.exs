defmodule Spider.Repo.Migrations.CreateLivestocks do
  use Ecto.Migration

  def change do
    create table(:livestocks) do
      
      add :quantity, :integer

      add :user_id, references(:users, on_delete: :nothing)
      add :business_id, references(:businesses, on_delete: :delete_all)
      add :dlivestock_id, references(:dlivestock, on_delete: :delete_all)

      timestamps()
    end

  end
end
