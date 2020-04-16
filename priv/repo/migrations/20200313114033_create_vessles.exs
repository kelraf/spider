defmodule Spider.Repo.Migrations.CreateVessles do
  use Ecto.Migration

  def change do
    create table(:vessles) do
      add :unique_number, :string
      add :status, :string

      add :user_id, references(:users, on_delete: :nothing)
      add :business_id, references(:businesses, on_delete: :delete_all)

      timestamps()
    end

    create unique_index(:vessles, [:unique_number])
  end
end
