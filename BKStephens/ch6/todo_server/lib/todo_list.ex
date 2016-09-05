defmodule TodoList do
  defstruct auto_id: 1, entries: HashDict.new

  def new(entries \\ []) do
    Enum.reduce(
      entries,
      %TodoList{},
      &add_entry(&2, &1)
    )
  end

  def add_entry(
    %TodoList{entries: entries, auto_id: auto_id} = todo_list,
    entry
  ) do
    entry = Map.put(entry, :id, auto_id)
    new_entries = HashDict.put(entries, auto_id, entry)

    %TodoList{todo_list |
      entries: new_entries,
      auto_id: auto_id + 1
    }
  end

  def update_entry(
    %TodoList{entries: entries} = todo_list,
    entry
  ) do
    {:ok, existing_entry} = HashDict.fetch(entries, entry.id)
    patched_entry = Map.merge(existing_entry, entry)
    new_entries = HashDict.put(entries, entry.id, patched_entry)
    %TodoList{todo_list | entries: new_entries}
  end

  def delete_entry(
    %TodoList{entries: entries} = todo_list,
    entry
  ) do
    new_entries = HashDict.delete(entries, entry.id)
    %TodoList{todo_list | entries: new_entries}
  end

  def entries(%TodoList{entries: entries}, date) do
    entries
    |> Stream.filter(fn({_, entry}) ->
         entry.date == date
       end)

    |> Enum.map(fn({_, entry}) ->
         entry
       end)
  end
end
