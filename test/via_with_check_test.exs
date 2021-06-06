defmodule ViaWithCheckUsageTest do
  @moduledoc """
  Docs Links:
  Gitee: https://gitee.com/lizhaochao/argx
  Github: https://github.com/lizhaochao/Argx
  """
  use ExUnit.Case

  ### Nested Data
  @cargoes [
    %{
      name: "cargo name1",
      types: [1, "2", 3],
      addr: %{city: "hn", town: "qh"},
      cameras: [
        %{ip: "192.168.0.111", location: "N1"},
        %{ip: "192.168.0.222", location: "S2"}
      ]
    },
    %{
      name: "cargo name2",
      types: [4, 5, "6"],
      addr: %{city: "sz", town: "ns"},
      cameras: [
        %{ip: "192.168.0.123", location: "N2"},
        %{ip: "192.168.0.124", location: "S3"}
      ]
    }
  ]

  test "type is nil - ok" do
    assert "nameaddrbig" == Warehouse.create_warehouse("name", nil, "addr", @cargoes)
  end

  test "type is 1 - ok" do
    assert "nameaddrbig" == Warehouse.create_warehouse("name", 1, "addr", @cargoes)
  end

  test "type is 2 - ok" do
    assert "nameaddrsmall" == Warehouse.create_warehouse("name", 2, "addr", @cargoes)
  end

  ### Check Box
  describe "check box" do
    test "ok - case 1" do
      assert {nil, "number"} == Warehouse.get_one(nil, "number")
    end

    test "ok - case 2" do
      assert {1, nil} == Warehouse.get_one("1", nil)
    end

    test "ok - case 3" do
      assert {1, "number"} == Warehouse.get_one("1", "number")
    end

    test "error" do
      result = Warehouse.get_one(nil, nil)
      assert %{error_msg: [checkbox_error: [:id, :number]], result: -10_001} == result
    end
  end

  ### Radio Box
  describe "radio box" do
    test "ok - case 1" do
      assert {nil, "number"} == Warehouse.get_many(nil, "number")
    end

    test "ok - case 2" do
      assert {1, nil} == Warehouse.get_many("1", nil)
    end

    test "error - case 1" do
      result = Warehouse.get_many("1", "number")
      assert %{error_msg: [radio_error: [:id, :number]], result: -10_001} == result
    end

    test "error - case 2" do
      result = Warehouse.get_many(nil, nil)
      assert %{error_msg: [radio_error: [:id, :number]], result: -10_001} == result
    end
  end
end
