defmodule TodoServerTest do
  use ExUnit.Case

  test "add_entry" do
    {:ok, pid} = TodoServer.start
    TodoServer.add_entry(pid, %{date: {2016, 9, 5}, title: "Write tests"})
    TodoServer.add_entry(pid, %{date: {2016, 9, 6}, title: "Profit"})
    assert [%{date: {2016, 9, 5}, id: 1, title: "Write tests"}] == TodoServer.entries(pid, {2016, 9, 5})
  end

  test "update_entry" do
    {:ok, pid} = TodoServer.start
    TodoServer.add_entry(pid, %{date: {2016, 9, 5}, title: "Write tests"})
    [%{id: id}] = TodoServer.entries(pid, {2016, 9, 5})
    TodoServer.update_entry(pid, %{id: id, title: "Write tests!"})
    assert [%{date: {2016, 9, 5}, id: 1, title: "Write tests!"}] == TodoServer.entries(pid, {2016, 9, 5})
  end

  test "delete_entry" do
    {:ok, pid} = TodoServer.start
    TodoServer.add_entry(pid, %{date: {2016, 9, 5}, title: "Write tests"})
    [%{id: id}] = TodoServer.entries(pid, {2016, 9, 5})
    TodoServer.delete_entry(pid, %{id: id})
    assert [] == TodoServer.entries(pid, {2016, 9, 5})
  end
end
