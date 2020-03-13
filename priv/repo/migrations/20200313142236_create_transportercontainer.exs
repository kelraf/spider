defmodule Spider.Repo.Migrations.CreateTransportercontainer do
  use Ecto.Migration

  def change do
    create table(:transportercontainer) do
      add :order_id, :integer

      add :user_id, references(:users, on_delete: :nothing)
      add :business_id, references(:businesses, on_delete: :delete_all)

      timestamps()
    end

  end
end
