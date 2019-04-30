defmodule HumanPlayerTest do
  use ExUnit.Case
  doctest HumanPlayer

  describe "when input is invalid" do
    setup do
      %{
        intermediary_board_state: %State{
          board: %{
            {0, 0} => "X",
            {0, 1} => "O",
            {0, 2} => "X",
            {1, 0} => 4,
            {1, 1} => 5,
            {1, 2} => 6,
            {2, 0} => 7,
            {2, 1} => 8,
            {2, 2} => 9
          },
          player: "X"
        }
      }
    end

    test "rejects invalid moves until valid move is entered", context do
      mock_deps = %{
        validation: MockValidation,
        messages: MockMessages,
        io: MockTTT.IO,
        human_player: MockHumanPlayer
      }

      Helpers.Stack.setup(["foo", "10\n", "1\n", "4\n"])

      assert HumanPlayer.analyze("move", context[:intermediary_board_state], mock_deps) == %State{
               board: %{
                 {0, 0} => "X",
                 {0, 1} => "O",
                 {0, 2} => "X",
                 {1, 0} => "X",
                 {1, 1} => 5,
                 {1, 2} => 6,
                 {2, 0} => 7,
                 {2, 1} => 8,
                 {2, 2} => 9
               },
               player: "O"
             }

      Helpers.Stack.teardown()
    end
  end

  test "rejects invalid input until user selects \"X\"" do
    Helpers.Stack.setup(["foo", "10\n", "1\n", "4\n", "x\n"])

    mock_deps = %{
      validation: MockValidation,
      messages: MockMessages,
      io: MockTTT.IO,
      human_player: MockHumanPlayer
    }

    assert HumanPlayer.choose_token(mock_deps) == "X"

    Helpers.Stack.teardown()
  end

  test "rejects invalid input until user selects \"O\"" do
    Helpers.Stack.setup(["foo", "10\n", "1\n", "4\n", "o\n"])

    mock_deps = %{
      validation: MockValidation,
      messages: MockMessages,
      io: MockTTT.IO,
      human_player: MockHumanPlayer
    }

    assert HumanPlayer.choose_token(mock_deps) == "O"

    Helpers.Stack.teardown()
  end
end
