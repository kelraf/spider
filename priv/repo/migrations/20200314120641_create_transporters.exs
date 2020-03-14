defmodule Spider.Repo.Migrations.CreateTransporters do
  use Ecto.Migration

  def change do
    create table(:transporters) do
      add :transporter_id, :integer
      add :longitude_from, :string
      add :latitude_from, :string
      add :longitude_to, :string
      add :latitude_to, :string
      add :status, :integer
      add :mode, :integer

      add :transporter_container_id, references(:transportercontainer, on_delete: :delete_all)

      timestamps()
    end

  end
end
