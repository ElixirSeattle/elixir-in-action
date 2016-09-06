defmodule TodoServer do
  use GenServer
  import TodoList

  #### External API

  def start do
    GenServer.start(TodoServer, nil)
  end

  def entries(todo_server, date) do
    GenServer.call(todo_server, {:entries, date})
  end

  def add_entry(todo_server, new_entry) do
    GenServer.cast(todo_server, {:add_entry, new_entry})
  end

  def update_entry(todo_server, entry) do
    GenServer.cast(todo_server, {:update_entry, entry})
  end

  def delete_entry(todo_server, entry) do
    GenServer.cast(todo_server, {:delete_entry, entry})
  end

  #### GenServer API

  def init(_) do
    {:ok, TodoList.new}
  end

  def handle_cast({:add_entry, new_entry}, todo_list) do
    {:noreply, TodoList.add_entry(todo_list, new_entry)}
  end

  def handle_cast({:update_entry, entry}, todo_list) do
    {:noreply, TodoList.update_entry(todo_list, entry)}
  end

  def handle_cast({:delete_entry, entry}, todo_list) do
    {:noreply, TodoList.delete_entry(todo_list, entry)}
  end

  def handle_call({:entries, date}, _, todo_list) do
    {:reply, TodoList.entries(todo_list, date), todo_list}
  end
end
