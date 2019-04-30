defmodule MessagesTest do
  use ExUnit.Case
  doctest Messages
  import ExUnit.CaptureIO

  test "get_message returns welcome message" do
    assert Messages.get_message(:welcome) == "Welcome to Tic Tac Toe!"
  end

  test "outputs initial board to the console" do
    empty_board_state = %State{}

    assert capture_io(fn -> Messages.display_board(empty_board_state, :console) end) ==
             ConsoleBoardPresenter.build(empty_board_state) <> "\n"
  end

  test "welcome message is displayed" do
    welcome_message = capture_io(fn -> Messages.welcome() end)

    assert String.contains?(welcome_message, "Welcome")
  end

  test "correct message is displayed" do
    tie_message = capture_io(fn -> Messages.display_message(%State{}, :tie) end)

    assert String.contains?(tie_message, "tie")
  end
end
