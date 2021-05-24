defmodule Spider.Repo.Migrations.CreateDLivestockSlaughterOutputs do
  use Ecto.Migration

  def change do
    create table(:d_livestock_slaughter_outputs) do
      add :output_name, :string
      add :units, :string
      add :checked, :boolean, default: false, null: false

      add :d_livestock_id, references(:dlivestock, on_delete: :delete_all)

      timestamps()
    end

  end
end
