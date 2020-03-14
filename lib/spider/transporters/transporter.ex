defmodule Spider.Transporters.Transporter do
  use Ecto.Schema
  import Ecto.Changeset

  alias Spider.TransporterContainers.TransporterContainer


  schema "transporters" do
    field :latitude_from, :string
    field :latitude_to, :string
    field :logitude_from, :string
    field :longitude_to, :string
    field :status, :integer, default: 0
    field :transporter_id, :integer
    field :mode, :integer

    belongs_to(:transporter_container, TransporterContainer)

    timestamps()
  end

  @doc false
  def changeset(transporter, attrs) do
    transporter
    |> cast(attrs, [:transporter_id, :logitude_from, :latitude_from, :longitude_to, :latitude_to, :status, :transporter_container_id, :mode])
    |> validate_required([:transporter_id, :logitude_from, :latitude_from, :longitude_to, :latitude_to, :status, :transporter_container_id, :mode])
  end
end
