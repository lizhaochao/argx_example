defmodule ArgxExample.Application do
  @moduledoc """
  Docs Links:
  Gitee: https://gitee.com/lizhaochao/argx
  Github: https://github.com/lizhaochao/Argx
  """
  use Application

  @impl true
  def start(_type, _args) do
    children = []
    opts = [strategy: :one_for_one, name: ArgxExample.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
