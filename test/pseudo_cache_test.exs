defmodule PseudoCacheTest do
  use ExUnit.Case

  test "puts new k/v pair to cache" do
    {:ok, pid} = PseudoCache.start_link()

    :ok = PseudoCache.put(pid, :a, 1)
    :ok = PseudoCache.put(pid, :b, 2)

    assert 1 == PseudoCache.get(pid, :a)
    assert 2 == PseudoCache.get(pid, :b)
  end

  test "deletes k/v pair from cache" do
    {:ok, pid} = PseudoCache.start_link()

    :ok = PseudoCache.put(pid, :a, 1)
    assert 1 == PseudoCache.get(pid, :a)

    :ok = PseudoCache.delete(pid, :a)
    assert nil == PseudoCache.get(pid, :a)
  end

  test "deletes k/v pair after expiration" do
    expiration = 3_000
    {:ok, pid} = PseudoCache.start_link()

    PseudoCache.put(pid, :a, 1, expiration)
    Process.sleep(1)
    PseudoCache.get(pid, :a)

    Process.sleep(expiration)
    assert nil == PseudoCache.get(pid, :a)
  end
end
