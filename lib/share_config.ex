defmodule Share.Configs do
  @moduledoc """
  Docs Links:
  Gitee: https://gitee.com/lizhaochao/argx
  Github: https://github.com/lizhaochao/Argx
  """
  use Argx.Defconfig

  defconfig(IDRule, id(:integer, :auto))
  defconfig(NameRule, name(:string))
  defconfig(MobileRule, mobile(:integer, :auto))

  defconfig(UserRule, [id(:integer, :auto), addr(:string), age(:integer, :auto)])

  defconfig(
    ListRules,
    [
      begin_time(:integer, :auto) || 0,
      end_time(:integer, :auto) || Helper.get_curr_ts(),
      page(:integer, :auto) || 0,
      page_size(:integer, :auto) || 10
    ]
  )

  ### Callback, effect User & Book modules and others.
  def fmt_errors({:error, err}), do: %{result: -10_001, error_msg: err}
  def fmt_errors(new_args), do: Map.new(new_args)
end
