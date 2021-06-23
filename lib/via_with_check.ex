defmodule Validator do
  @moduledoc """
  Docs Links:
  Gitee: https://gitee.com/lizhaochao/argx
  Github: https://github.com/lizhaochao/Argx
  """
  use Argx.WithCheck, share: Share.Configs

  ### Callback, Only effect Warehouse modules.
  def fmt_errors({:error, err}), do: %{result: -20_001, error_msg: err}
  def fmt_errors(new_args), do: Map.new(new_args)
end

defmodule Warehouse do
  import Validator

  @big_type 1
  @small_type 2

  def big_type, do: @big_type
  def small_type, do: @small_type

  defconfig(AddrRule, addr(:string))

  defconfig(TypeListRule, _(:integer, :autoconvert))
  defconfig(CameraListRule, [ip(:string), location(:string)])
  defconfig(AddrMapRule, [city(:string), town(:string)])

  defconfig(CargoRule, [
    name(:string),
    types({:list, TypeListRule}),
    addr({:map, AddrMapRule}),
    cameras({:list, CameraListRule})
  ])

  defconfig(CargoesRule, cargoes({:list, CargoRule}))

  ### Nested Data
  with_check configs(
               type(:integer, :autoconvert) || big_type(),
               NameRule,
               AddrRule,
               CargoesRule
             ) do
    def create_warehouse(name, type, addr, cargoes) when type == @small_type do
      {cargoes}
      IO.iodata_to_binary([name, addr, "small"])
    end

    def create_warehouse(name, type, addr, cargoes) do
      {cargoes}
      type_text = if type == @big_type, do: "big", else: "small"
      IO.iodata_to_binary([name, addr, type_text])
    end
  end

  ### Check Box Functionality
  with_check configs(
               id(:integer, :autoconvert, :checkbox),
               number(:string, :checkbox)
             ) do
    def get_one(id, number) do
      {id, number}
    end
  end

  ### Radio Box Functionality
  with_check configs(
               id(:integer, :autoconvert, :radio),
               number(:string, :radio)
             ) do
    def get_many(id, number) do
      {id, number}
    end
  end
end
