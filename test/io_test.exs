defmodule TTT.IOTest do
  use ExUnit.Case

  import ExUnit.CaptureIO

  test "retrieve gets user's input" do
    Helpers.Stack.setup(["user input"])

    assert TTT.IO.retrieve(MockTTT.IO, :choose) == "user input"

    Helpers.Stack.teardown()
  end

  test "outputs a message" do
    message = capture_io(fn -> TTT.IO.display("hi") end)
    assert message == "hi\n"
  end
end
