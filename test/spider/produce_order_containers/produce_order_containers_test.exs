defmodule Spider.ProduceOrderContainersTest do
  use Spider.DataCase

  alias Spider.ProduceOrderContainers

  describe "produce_order_containers" do
    alias Spider.ProduceOrderContainers.ProduceOrderContainer

    @valid_attrs %{business_from_id: 42, channel: "some channel", payment_status: "some payment_status", status: 42}
    @update_attrs %{business_from_id: 43, channel: "some updated channel", payment_status: "some updated payment_status", status: 43}
    @invalid_attrs %{business_from_id: nil, channel: nil, payment_status: nil, status: nil}

    def produce_order_container_fixture(attrs \\ %{}) do
      {:ok, produce_order_container} =
        attrs
        |> Enum.into(@valid_attrs)
        |> ProduceOrderContainers.create_produce_order_container()

      produce_order_container
    end

    test "list_produce_order_containers/0 returns all produce_order_containers" do
      produce_order_container = produce_order_container_fixture()
      assert ProduceOrderContainers.list_produce_order_containers() == [produce_order_container]
    end

    test "get_produce_order_container!/1 returns the produce_order_container with given id" do
      produce_order_container = produce_order_container_fixture()
      assert ProduceOrderContainers.get_produce_order_container!(produce_order_container.id) == produce_order_container
    end

    test "create_produce_order_container/1 with valid data creates a produce_order_container" do
      assert {:ok, %ProduceOrderContainer{} = produce_order_container} = ProduceOrderContainers.create_produce_order_container(@valid_attrs)
      assert produce_order_container.business_from_id == 42
      assert produce_order_container.channel == "some channel"
      assert produce_order_container.payment_status == "some payment_status"
      assert produce_order_container.status == 42
    end

    test "create_produce_order_container/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = ProduceOrderContainers.create_produce_order_container(@invalid_attrs)
    end

    test "update_produce_order_container/2 with valid data updates the produce_order_container" do
      produce_order_container = produce_order_container_fixture()
      assert {:ok, produce_order_container} = ProduceOrderContainers.update_produce_order_container(produce_order_container, @update_attrs)
      assert %ProduceOrderContainer{} = produce_order_container
      assert produce_order_container.business_from_id == 43
      assert produce_order_container.channel == "some updated channel"
      assert produce_order_container.payment_status == "some updated payment_status"
      assert produce_order_container.status == 43
    end

    test "update_produce_order_container/2 with invalid data returns error changeset" do
      produce_order_container = produce_order_container_fixture()
      assert {:error, %Ecto.Changeset{}} = ProduceOrderContainers.update_produce_order_container(produce_order_container, @invalid_attrs)
      assert produce_order_container == ProduceOrderContainers.get_produce_order_container!(produce_order_container.id)
    end

    test "delete_produce_order_container/1 deletes the produce_order_container" do
      produce_order_container = produce_order_container_fixture()
      assert {:ok, %ProduceOrderContainer{}} = ProduceOrderContainers.delete_produce_order_container(produce_order_container)
      assert_raise Ecto.NoResultsError, fn -> ProduceOrderContainers.get_produce_order_container!(produce_order_container.id) end
    end

    test "change_produce_order_container/1 returns a produce_order_container changeset" do
      produce_order_container = produce_order_container_fixture()
      assert %Ecto.Changeset{} = ProduceOrderContainers.change_produce_order_container(produce_order_container)
    end
  end
end
