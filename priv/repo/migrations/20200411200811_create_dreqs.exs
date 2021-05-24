defmodule Spider.Repo.Migrations.CreateDreqs do
  use Ecto.Migration

  def change do
    create table(:dreqs) do
      add :requirement, :string

      add :d_role_id, references(:droles, on_delete: :delete_all)

      timestamps()
    end

  end
end
