defmodule TTT.IOTest do
  use ExUnit.Case

  test "retrieve gets user's input" do
    Helpers.Stack.setup(["user input"])

    assert TTT.IO.retrieve(MockInput, :choose) == "user input"

    Helpers.Stack.teardown()
  end
end
