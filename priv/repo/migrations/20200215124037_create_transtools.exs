defmodule Spider.Repo.Migrations.CreateTranstools do
  use Ecto.Migration

  def change do
    create table(:transtools) do
      add :registration_number, :string
      add :brand, :string
      add :model, :string
      add :role, :string
      add :business_id, references(:businesses, on_delete: :delete_all)
      add :user_id, references(:users, on_delete: :nothing)

      timestamps()
    end

    create unique_index(:transtools, [:registration_number])
  end
end
