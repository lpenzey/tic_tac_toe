defmodule OutputTest do
  use ExUnit.Case
  doctest Output
  import ExUnit.CaptureIO

  test "get_message returns welcome message" do
    assert Output.get_message(:welcome) == "Welcome to Tic Tac Toe!"
  end

  test "outputs initial board to the console" do
    empty_board_state = %State{}

    assert capture_io(fn -> Output.display_board(empty_board_state, :console) end) ==
             Board.build(empty_board_state) <> "\n"
  end

  test "welcome message is displayed" do
    welcome_message = capture_io(fn -> Output.welcome() end)

    assert String.contains?(welcome_message, "Welcome")
  end

  test "correct message is displayed" do
    tie_message = capture_io(fn -> Output.display_message(%State{}, :tie) end)

    assert String.contains?(tie_message, "tie")
  end
end
