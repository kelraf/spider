defmodule Spider.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :phone_number, :string
      add :email, :string
      add :password_hash, :string
      add :first_name, :string
      add :last_name, :string
      add :role, :string
      add :national_id_number, :integer
      add :pin, :string
      add :country_code, :string
      add :location, :string

      timestamps()
    end

    create unique_index(:users, [:phone_number])
    create unique_index(:users, [:email])
    create unique_index(:users, [:national_id_number])
  end
end