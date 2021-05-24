defmodule Spider.Repo.Migrations.CreateVehicles do
  use Ecto.Migration

  def change do
    create table(:vehicles) do
      add :registration_number, :string
      add :type, :string
      add :status, :string

      add :user_id, references(:users, on_delete: :nothing)
      add :business_id, references(:businesses, on_delete: :delete_all)

      timestamps()
    end

    create unique_index(:vehicles, [:registration_number])
  end
end
