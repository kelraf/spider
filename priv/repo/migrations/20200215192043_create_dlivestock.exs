defmodule Spider.Repo.Migrations.CreateDlivestock do
  use Ecto.Migration

  def change do
    create table(:dlivestock) do
      
      add :reference, :string
      add :type, :string
      add :breed, :string
      add :category, :string

      timestamps()
    end

  end
end
