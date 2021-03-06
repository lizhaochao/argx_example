defmodule AuthCenter do
  @moduledoc """
  Docs Links:
  Gitee: https://gitee.com/lizhaochao/argx
  Github: https://github.com/lizhaochao/Argx
  """
  use Argx, warn: false

  defconfig(
    SignInRules,
    [username(:string) || "ljy", password(:string)]
  )

  ### Callback, Only effect current module.
  def fmt_errors({:error, err}), do: %{result: -1, error_msg: err}
  def fmt_errors(new_args), do: Keyword.new(new_args)

  def sign_in(username, password) do
    with(
      params <- [username: username, password: password],
      [password: new_password, username: new_username] <- check(params, [SignInRules]),
      true <- new_username == "ljy" and new_password == "lijiayou"
    ) do
      :ok
    else
      false -> :username_or_password_wrong
      err -> err
    end
  end
end

defmodule User do
  use Argx, share: Share.Configs

  defconfig(RoleRule, _(:integer, :autoconvert))
  defconfig(RolesRule, roles({:list, RoleRule}))

  defconfig(
    UpdateUserRule,
    [institution(:integer, :autoconvert), users({:list, UserRule})]
  )

  def create_user(params), do: check(params, [NameRule, MobileRule, RolesRule])
  def update_users(params), do: check(params, [UpdateUserRule])
  def get_users(params), do: check(params, [ListRules])
end

defmodule Book do
  use Argx, share: Share.Configs

  defconfig(PagesRule, pages(:integer, :autoconvert))
  defconfig(IsPublishRule, is_publish(:boolean, :autoconvert) || false)

  def create_book(name, pages, is_publish) do
    params = %{name: name, pages: pages, is_publish: is_publish}
    check(params, [NameRule, PagesRule, IsPublishRule])
  end

  def get_list(begin_time, end_time, page, page_size) do
    params = [begin_time: begin_time, end_time: end_time, page: page, page_size: page_size]
    check(params, [ListRules])
  end
end

defmodule Helper do
  def get_curr_ts, do: 1_622_961_616
end
