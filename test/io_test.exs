defmodule TTT.IOTest do
  use ExUnit.Case

  test "retrieve gets user's input" do
    Helpers.Stack.setup(["user input"])

    assert TTT.IO.retrieve(MockTTT.IO, :choose) == "user input"

    Helpers.Stack.teardown()
  end

  test "outputs a message" do
    assert TTT.IO.display(MockTTT.IO, "hi") == "hi"
  end
end
