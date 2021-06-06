defmodule ViaCheckUsageTest do
  @moduledoc """
  Docs Links:
  Gitee: https://gitee.com/lizhaochao/argx
  Github: https://github.com/lizhaochao/Argx
  """
  use ExUnit.Case

  ### AuthCenter ###
  test "sign_in - ok" do
    assert :ok == AuthCenter.sign_in("ljy", "lijiayou")
  end

  test "sign_in - ok - username as nil" do
    assert :ok == AuthCenter.sign_in(nil, "lijiayou")
  end

  test "sign_in - error" do
    %{error_msg: [error_type: [:password]], result: -1} = AuthCenter.sign_in("ljy", 460_200)
  end

  ### User ###
  test "create_user - ok" do
    params = %{name: "lzc", mobile: "10000000000", roles: [1, 2, "3"]}
    result = User.create_user(params)
    %{name: "lzc", mobile: 10_000_000_000, roles: [1, 2, 3]} = result
  end

  # Nested Data
  test "update_user - ok" do
    params = %{
      institution: 1,
      users: [
        %{id: 1, addr: "hn", age: "18"},
        %{id: "2", addr: "sz", age: 47}
      ]
    }

    result = User.update_users(params)

    %{
      institution: 1,
      users: [
        %{id: 1, addr: "hn", age: 18},
        %{id: 2, addr: "sz", age: 47}
      ]
    } = result
  end

  test "get_users - ok" do
    params = %{begin_time: nil, end_time: nil, page: nil, page_size: nil}
    result = User.get_users(params)
    %{begin_time: 0, end_time: 1_622_961_616, page: 0, page_size: 10} = result
  end

  ### Book ###
  test "create_book - ok" do
    result = Book.create_book("book name", 203, "1")
    %{name: "book name", pages: 203, is_publish: true} = result
  end

  test "get_list - ok" do
    result = Book.get_list(nil, nil, 1, 20)
    %{begin_time: 0, end_time: 1_622_961_616, page: 1, page_size: 20} = Map.new(result)
  end

  test "get_list - error" do
    %{error_msg: [error_type: [:begin_time]], result: -10_001} = Book.get_list(1.2, nil, 1, 20)
  end
end
