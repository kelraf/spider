defmodule Spider.Repo.Migrations.CreateBusinesses do
  use Ecto.Migration

  def change do
    create table(:businesses) do
      add :business_name, :string
      add :business_pin, :string
      add :registration_number, :string
      add :business_type, :string
      add :category, :string
      add :sub_category, :string
      add :status, :integer
      add :country_name, :string
      add :currency, :string
      add :currency_name, :string
      add :continent_code, :string
      add :country_calling_code, :string
      add :latitude, :string
      add :longitude, :string

      add :user_id, references(:users, on_delete: :nothing), null: false

      timestamps()
    end

    create unique_index(:businesses, [:business_pin])
    create unique_index(:businesses, [:registration_number])
  end
end
