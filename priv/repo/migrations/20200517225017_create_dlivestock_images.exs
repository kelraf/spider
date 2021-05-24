defmodule Spider.Repo.Migrations.CreateDlivestockImages do
  use Ecto.Migration

  def change do
    create table(:dlivestock_images) do

      add :uuid, :string
      add :image, :string
      add :d_livestock_id, references(:dlivestock, on_delete: :delete_all)

      timestamps()
    end

  end
end
