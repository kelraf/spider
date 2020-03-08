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
      add :status, :integer
      add :national_id_number, :integer
      add :pin, :string
      add :country_name, :string
      add :currency, :string
      add :currency_name, :string
      add :continent_code, :string
      add :country_calling_code, :string
      add :latitude, :string
      add :longitude, :string

      timestamps()
    end

    create unique_index(:users, [:phone_number])
    create unique_index(:users, [:email])
    create unique_index(:users, [:national_id_number])
  end
end
