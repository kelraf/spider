defmodule Spider.Repo.Migrations.CreateTranstooluserrels do
  use Ecto.Migration

  def change do
    create table(:transtooluserrels) do
      
      add :user_id, references(:users, on_delete: :delete_all)
      add :business_id, references(:businesses, on_delete: :delete_all)
      add :transtool_id, references(:transtools, on_delete: :delete_all)

      timestamps()
    end

  end
end
