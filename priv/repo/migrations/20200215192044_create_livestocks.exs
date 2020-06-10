defmodule Spider.Repo.Migrations.CreateLivestocks do
  use Ecto.Migration

  def change do
    create table(:livestocks) do
      
      add :quantity, :integer

      add :user_id, references(:users, on_delete: :nothing)
      add :business_id, references(:businesses, on_delete: :delete_all)
      add :d_livestock_id, references(:dlivestock, on_delete: :delete_all)
      add :price, :integer
      add :status, :integer

      timestamps()
    end

  end
end
