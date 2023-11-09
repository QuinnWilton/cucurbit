defmodule CucurbitTest do
  use ExUnit.Case
  doctest Cucurbit

  test "greets the world" do
    assert Cucurbit.hello() == :world
  end
end
