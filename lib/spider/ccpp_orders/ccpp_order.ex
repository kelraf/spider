defmodule Spider.CCPPOrders.CCPPOrder do
  use Ecto.Schema
  use Arc.Ecto.Schema
  import Ecto.Changeset

  alias Spider.ProduceOrderStages.ProduceOrderStage

  schema "c_c_p_p_orders" do

    field(:file, Spider.CCPPOrderUploads.Type)
    field :purpose, :string
    field(:uuid, :string)

    belongs_to(:produce_order_stage, ProduceOrderStage)

    timestamps()
  end

  @doc false
  def changeset(ccpp_order, attrs) do
    ccpp_order
    |> cast(attrs, [:purpose, :produce_order_stage_id, :uuid])
    |> put_change(:uuid, Ecto.UUID.generate())
    |> validate_required([:purpose, :uuid, :produce_order_stage_id])
    |> cast_attachments(attrs, [:file])
    |> create_file_name()
  end

  defp create_file_name(changeset) do
    case get_field(changeset, :produce_order_stage_id) do
      nil ->
        changeset
      produce_order_stage_id ->
        case get_field(changeset, :file) do
          nil ->
            changeset
          file ->
            case get_field(changeset, :uuid) do
              nil ->
                changeset
              uuid ->
                new_file = Map.put(file, :file_name, "spider_#{uuid}_#{produce_order_stage_id}#{Path.extname(file.file_name)}")
                put_change(changeset, :file, new_file)
            end
        end
    end
  end

end
