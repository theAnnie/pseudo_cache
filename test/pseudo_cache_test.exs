defmodule PseudoCacheTest do
  use ExUnit.Case
  doctest PseudoCache

  test "greets the world" do
    assert PseudoCache.hello() == :world
  end
end
