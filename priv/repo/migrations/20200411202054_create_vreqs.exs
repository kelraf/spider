defmodule Spider.Repo.Migrations.CreateVreqs do
  use Ecto.Migration

  def change do
    create table(:vreqs) do
      add :available, :boolean, default: false, null: false

      add :d_req_id, references(:dreqs, on_delete: :nothing)
      add :v_role_id, references(:vroles, on_delete: :nothing)

      timestamps()
    end

  end
end
