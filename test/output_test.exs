defmodule OutputTest do
  use ExUnit.Case
  doctest Output
  import ExUnit.CaptureIO

  test "get_message returns welcome message" do
    assert Output.get_message(:welcome) == "Welcome to Tic Tac Toe!"
  end

  test "print_board outputs initial board to the console" do
    empty_board_state = %State{}

    assert capture_io(fn -> Output.print_board(empty_board_state, :console) end) ==
             Board.build(empty_board_state) <> "\n"
  end

  test "welcome outputs to console when client is the console" do
    assert capture_io(fn -> Output.welcome(:console) end) ==
             "Welcome to Tic Tac Toe!\nPlease choose a spot by entering 1 - 9\n"
  end
end
