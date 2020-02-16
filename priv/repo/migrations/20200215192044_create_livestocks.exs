defmodule Spider.Repo.Migrations.CreateLivestocks do
  use Ecto.Migration

  def change do
    create table(:livestocks) do

      add :type, :string
      add :category, :string
      add :number, :integer

      add :user_id, references(:users, on_delete: :nothing)
      add :business_id, references(:businesses, on_delete: :delete_all)

      timestamps()
    end

  end
end
