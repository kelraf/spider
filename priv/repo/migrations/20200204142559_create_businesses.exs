defmodule Spider.Repo.Migrations.CreateBusinesses do
  use Ecto.Migration

  def change do
    create table(:businesses) do
      add :business_name, :string
      add :kra_pin, :string
      add :registration_number, :string
      add :business_type, :integer
      add :country_code, :string
      add :county, :string
      add :sub_county, :string
      add :ward, :string
      add :location, :string

      add :user_id, references(:users, on_delete: :nothing)

      timestamps()
    end

    create unique_index(:businesses, [:kra_pin])
    create unique_index(:businesses, [:registration_number])
  end
end
