defmodule TodoServer do
  import ServerProcess
  import TodoList

  #### External API

  def start do
    ServerProcess.start(TodoServer)
  end

  def entries(todo_server, date) do
    ServerProcess.call(todo_server, {:entries, date})
  end

  def add_entry(todo_server, new_entry) do
    ServerProcess.cast(todo_server, {:add_entry, new_entry})
  end

  def update_entry(todo_server, entry) do
    ServerProcess.cast(todo_server, {:update_entry, entry})
  end

  def delete_entry(todo_server, entry) do
    ServerProcess.cast(todo_server, {:delete_entry, entry})
  end

  #### ServerProcess API

  def init do
    TodoList.new
  end

  def handle_cast({:add_entry, new_entry}, todo_list) do
    TodoList.add_entry(todo_list, new_entry)
  end

  def handle_cast({:update_entry, entry}, todo_list) do
    TodoList.update_entry(todo_list, entry)
  end

  def handle_cast({:delete_entry, entry}, todo_list) do
    TodoList.delete_entry(todo_list, entry)
  end

  def handle_call({:entries, date}, todo_list) do
    {TodoList.entries(todo_list, date), todo_list}
  end
end
