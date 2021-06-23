defmodule Share.Configs do
  @moduledoc """
  Docs Links:
  Gitee: https://gitee.com/lizhaochao/argx
  Github: https://github.com/lizhaochao/Argx
  """
  use Argx.Defconfig

  defconfig(IDRule, id(:integer, :autoconvert))
  defconfig(NameRule, name(:string))
  defconfig(MobileRule, mobile(:integer, :autoconvert))

  defconfig(UserRule, [id(:integer, :autoconvert), addr(:string), age(:integer, :autoconvert)])

  defconfig(
    ListRules,
    [
      begin_time(:integer, :autoconvert) || 0,
      end_time(:integer, :autoconvert) || Helper.get_curr_ts(),
      page(:integer, :autoconvert) || 0,
      page_size(:integer, :autoconvert) || 10
    ]
  )

  ### Callback, effect User & Book modules and others.
  def fmt_errors({:error, err}), do: %{result: -10_001, error_msg: err}
  def fmt_errors(new_args), do: Map.new(new_args)
end
