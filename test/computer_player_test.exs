defmodule ComputerPlayerTest do
  use ExUnit.Case
  doctest ComputerPlayer

  describe "when board is empty" do
    setup do
      %{
        initial_state: %State{
          board: %{
            {0, 0} => 1,
            {0, 1} => 2,
            {0, 2} => 3,
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

    test "finds all open spaces", context do
      assert ComputerPlayer.available_moves(context[:initial_state]) == %{
               {0, 0} => 1,
               {0, 1} => 2,
               {0, 2} => 3,
               {1, 0} => 4,
               {1, 1} => 5,
               {1, 2} => 6,
               {2, 0} => 7,
               {2, 1} => 8,
               {2, 2} => 9
             }
    end

    test "returns a random key of an open space", context do
      move = ComputerPlayer.select_move(context[:initial_state])
      assert Map.fetch!(ComputerPlayer.available_moves(context[:initial_state]), move)
    end

    test "enters move into board state", context do
      computer_move_state = ComputerPlayer.make_move(context[:initial_state])
      board_values = Map.values(computer_move_state.board)

      assert Enum.find(board_values, fn x -> x == "X" end) == "X"
    end
  end

  describe "when board has one move" do
    setup do
      %{
        one_move_state: %State{
          board: %{
            {0, 0} => "X",
            {0, 1} => 2,
            {0, 2} => 3,
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

    test "finds all open spaces", context do
      assert ComputerPlayer.available_moves(context[:one_move_state]) == %{
               {0, 1} => 2,
               {0, 2} => 3,
               {1, 0} => 4,
               {1, 1} => 5,
               {1, 2} => 6,
               {2, 0} => 7,
               {2, 1} => 8,
               {2, 2} => 9
             }
    end

    test "returns a random key of an open space", context do
      move = ComputerPlayer.select_move(context[:one_move_state])
      assert Map.fetch!(ComputerPlayer.available_moves(context[:one_move_state]), move)
    end
  end

  describe "when board is nearly full" do
    setup do
      %{
        nearly_full_board_state: %State{
          board: %{
            {0, 0} => "X",
            {0, 1} => "O",
            {0, 2} => "X",
            {1, 0} => "O",
            {1, 1} => "X",
            {1, 2} => "O",
            {2, 0} => "X",
            {2, 1} => "O",
            {2, 2} => 9
          },
          player: "X"
        }
      }
    end

    test "finds the only open space", context do
      assert ComputerPlayer.available_moves(context[:nearly_full_board_state]) == %{{2, 2} => 9}
    end

    test "returns key of the only open space", context do
      assert ComputerPlayer.select_move(context[:nearly_full_board_state]) == {2, 2}
    end
  end

  describe "when board is full" do
    setup do
      %{
        full_board_state: %State{
          board: %{
            {0, 0} => "X",
            {0, 1} => "O",
            {0, 2} => "X",
            {1, 0} => "O",
            {1, 1} => "X",
            {1, 2} => "O",
            {2, 0} => "X",
            {2, 1} => "O",
            {2, 2} => "X"
          },
          player: "X"
        }
      }
    end

    test "returns an empty map", context do
      assert ComputerPlayer.available_moves(context[:full_board_state]) == %{}
    end

    test "returns empty error message", context do
      assert ComputerPlayer.select_move(context[:full_board_state]) ==
               {:error, "empty error"}
    end

    test "returns state when board is full", context do
      assert ComputerPlayer.make_move(context[:full_board_state]) == context[:full_board_state]
    end
  end
end
