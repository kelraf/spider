defmodule Spider.CCPLOrders.CCPLOrder do
  use Ecto.Schema
  use Arc.Ecto.Schema
  import Ecto.Changeset

  alias Spider.LivestockOrderStages.LivestockOrderStage

  schema "c_c_p_l_orders" do
    field(:file, Spider.CCPLOrderUploads.Type)
    field(:purpose, :string)
    field(:uuid, :string)

    belongs_to(:livestock_order_stage, LivestockOrderStage)

    timestamps()
  end

  @doc false
  def changeset(ccpl_order, attrs) do
    ccpl_order
    |> cast(attrs, [:purpose, :livestock_order_stage_id, :uuid])
    |> put_change(:uuid, Ecto.UUID.generate())
    |> validate_required([:purpose, :uuid, :livestock_order_stage_id])
    |> cast_attachments(attrs, [:file])
    |> create_file_name()
  end

  defp create_file_name(changeset) do
    case get_field(changeset, :livestock_order_stage_id) do
      nil ->
        changeset

      livestock_order_stage_id ->
        case get_field(changeset, :file) do
          nil ->
            changeset

          file ->
            case get_field(changeset, :uuid) do
              nil ->
                changeset

              uuid ->
                new_file =
                  Map.put(
                    file,
                    :file_name,
                    "spider_#{uuid}_#{livestock_order_stage_id}#{Path.extname(file.file_name)}"
                  )

                put_change(changeset, :file, new_file)
            end
        end
    end
  end
end
