defmodule Game_test do
  use ExUnit.Case
  doctest Game

  @tag :skip
  test "does a thing" do
    s = %State{}
    assert Game.play("1", s) == 1
  end
end
