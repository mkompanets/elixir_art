defmodule ElixirArtTest do
  use ExUnit.Case
  doctest ElixirArt

  test "greets the world" do
    assert ElixirArt.hello() == :world
  end
end
