defmodule Spider.Context.LivestockOrderStagesCenterOrders do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query, only: [from: 2]

  alias Spider.Repo
  alias Spider.CenterOrders

  def create_center_order(
        data = %{
          stage_name: stage_name,
          status: status,
          id: id,
          livestock_order_id: livestock_order_id
        }
      ) do
    IO.puts("From Livestock Stage")
    data = IO.inspect(data |> Repo.preload(:livestock_order))

    case stage_name do
      "collection" ->
        center_order_data = %{
          required_animals: data.livestock_order.quantity,
          livestock_order_id: data.livestock_order.id,
          d_livestock_id: data.livestock_order.d_livestock_id,
          livestock_order_stage_id: data.id
        }

        IO.inspect(center_order_data)

        CenterOrders.create_center_order(center_order_data |> IO.inspect())

      "ccp" ->
        IO.puts("Nothing To Do")

      _ ->
        IO.puts("Nothing To Do")
    end
  end

  def create_center_order(
        data = %{
          user_id: user_id,
          id: id,
          status: status,
          channel: channel,
          business_id: business_id,
          business_from_id: business_from_id
        }
      ) do
    IO.puts("From Livestock Order Container")

    case Map.get(data, :livestock_orders) do
      nil ->
        IO.puts("No Livestock Orders")

      livestock_orders ->
        Enum.each(livestock_orders, fn livestock_order ->
          case Map.get(livestock_order, :livestock_order_stages) do
            nil ->
              IO.inspect("No LivestockOrder Stages")

            livestock_order_stages ->
              Enum.each(livestock_order_stages, fn livestock_order_stage ->
                __MODULE__.create_center_order(livestock_order_stage)
              end)
          end
        end)
    end
  end

  def spawn_task(match = {:ok, data}) do
    Task.start(fn ->
      Process.sleep(10000)
      __MODULE__.create_center_order(data)
    end)

    match
  end

  def spawn_task(match = {:error, _data}) do
    IO.inspect(match)
  end
end
