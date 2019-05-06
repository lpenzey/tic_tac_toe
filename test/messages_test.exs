defmodule MessagesTest do
  use ExUnit.Case
  doctest Messages

  test "get_message returns welcome message" do
    assert Regex.match?(~r/Welcome/, Messages.get_message(:welcome))
  end

  test "outputs initial board to the console" do
    empty_board_state = %State{}

    assert Messages.display_board(MockTTT.IO, empty_board_state) ==
             ConsoleBoardPresenter.build(empty_board_state)
  end

  test "correct message is displayed" do
    assert Regex.match?(~r/tie/, Messages.display_message(MockTTT.IO, :tie))
  end
end
