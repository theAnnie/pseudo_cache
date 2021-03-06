defmodule PseudoCache do
  @moduledoc false

  use GenServer

  def start_link(cache \\ %{}) when is_map(cache) do
    GenServer.start_link(__MODULE__, cache)
  end

  def put(pid, key, element) do
    GenServer.cast(pid, {:put, key, element})
  end

  def put(pid, key, element, expiration) when is_number(expiration) do
    spawn(fn ->
      GenServer.cast(pid, {:put, key, element})
      Process.sleep(expiration)
      GenServer.cast(pid, {:delete, key})
    end)

    :ok
  end

  def delete(pid, key) do
    GenServer.cast(pid, {:delete, key})
  end

  def get(pid, key) do
    GenServer.call(pid, {:get, key})
  end

  # Server callbacks

  @impl true
  def init(cache) do
    {:ok, cache}
  end

  @impl true
  def handle_cast({:put, key, element}, state) do
    {:noreply, Map.put(state, key, element)}
  end

  @impl true
  def handle_cast({:delete, key}, state) do
    {:noreply, Map.delete(state, key)}
  end

  @impl true
  def handle_call({:get, key}, _from, state) do
    {:reply, Map.get(state, key), state}
  end
end
