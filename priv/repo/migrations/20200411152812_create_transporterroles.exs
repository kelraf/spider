defmodule Spider.Repo.Migrations.CreateTransporterroles do
  use Ecto.Migration

  def change do
    create table(:transporterroles) do
      add :status, :string
      
      add :admin_transporter_role_id, references(:admintransporterroles, on_delete: :nothing)
      add :vehicle_id, references(:vehicles, :on_delete: :delete_all)
      add :flight_id, references(:flights, :on_delete: :delete_all)
      add :train_id, references(:trains, :on_delete: :delete_all)
      add :vessle_id, references(:vessles, :on_delete: :delete_all)

      timestamps()
    end

  end
end
