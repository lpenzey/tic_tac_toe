defmodule StatusTest do
  use ExUnit.Case
  doctest Status

  describe "when board is empty" do
    setup do
      %{
        initial_board: %{
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
      }
    end

    test "finds board dimension", context do
      assert Status.board_dimension(context[:initial_board]) == 3
    end

    test "generates row triplets", context do
      assert Status.rows(context[:initial_board]) == [
               [{0, 0}, {0, 1}, {0, 2}],
               [{1, 0}, {1, 1}, {1, 2}],
               [{2, 0}, {2, 1}, {2, 2}]
             ]
    end

    test "generates column triplets", context do
      assert Status.columns(context[:initial_board]) == [
               [{0, 0}, {1, 0}, {2, 0}],
               [{0, 1}, {1, 1}, {2, 1}],
               [{0, 2}, {1, 2}, {2, 2}]
             ]
    end

    test "generates first diagonal triplets", context do
      assert Status.first_diagonal(context[:initial_board]) ==
               [{0, 0}, {1, 1}, {2, 2}]
    end

    test "generates second diagonal triplets", context do
      assert Status.second_diagonal(context[:initial_board]) ==
               [{2, 0}, {1, 1}, {0, 2}]
    end

    test "generates both diagonal triplets", context do
      assert Status.diagonals(context[:initial_board]) ==
               [[{0, 0}, {1, 1}, {2, 2}], [{2, 0}, {1, 1}, {0, 2}]]
    end

    test "generates all winning combinations for 3x3 board", context do
      assert Status.win_combinations(context[:initial_board]) ==
               [
                 [{0, 0}, {0, 1}, {0, 2}],
                 [{1, 0}, {1, 1}, {1, 2}],
                 [{2, 0}, {2, 1}, {2, 2}],
                 [{0, 0}, {1, 0}, {2, 0}],
                 [{0, 1}, {1, 1}, {2, 1}],
                 [{0, 2}, {1, 2}, {2, 2}],
                 [{0, 0}, {1, 1}, {2, 2}],
                 [{2, 0}, {1, 1}, {0, 2}]
               ]
    end

    test "generates all winning combination triplets for 4x4 board" do
      four_board = %{
        {0, 0} => 1,
        {0, 1} => 2,
        {0, 2} => 3,
        {0, 3} => 4,
        {1, 0} => 5,
        {1, 1} => 6,
        {1, 2} => 7,
        {1, 3} => 8,
        {2, 0} => 9,
        {2, 1} => 10,
        {2, 2} => 11,
        {2, 3} => 12,
        {3, 0} => 13,
        {3, 1} => 14,
        {3, 2} => 15,
        {3, 3} => 16
      }

      assert Status.win_combinations(four_board) ==
               [
                 [{0, 0}, {0, 1}, {0, 2}, {0, 3}],
                 [{1, 0}, {1, 1}, {1, 2}, {1, 3}],
                 [{2, 0}, {2, 1}, {2, 2}, {2, 3}],
                 [{3, 0}, {3, 1}, {3, 2}, {3, 3}],
                 [{0, 0}, {1, 0}, {2, 0}, {3, 0}],
                 [{0, 1}, {1, 1}, {2, 1}, {3, 1}],
                 [{0, 2}, {1, 2}, {2, 2}, {3, 2}],
                 [{0, 3}, {1, 3}, {2, 3}, {3, 3}],
                 [{0, 0}, {1, 1}, {2, 2}, {3, 3}],
                 [{3, 0}, {2, 1}, {1, 2}, {0, 3}]
               ]
    end

    test "status win is false", context do
      assert Status.win?(context[:initial_board]) == false
    end

    test "status tie is false", context do
      assert Status.tie(context[:initial_board]) == false
    end

    test "status over is false", context do
      assert Status.over(context[:initial_board]) == :game_in_progress
    end
  end

  describe "when a player has almost won" do
    setup do
      %{
        nearly_full_board: %{
          {0, 0} => "X",
          {0, 1} => "O",
          {0, 2} => "X",
          {1, 0} => "O",
          {1, 1} => "X",
          {1, 2} => "O",
          {2, 0} => 7,
          {2, 1} => 8,
          {2, 2} => 9
        }
      }
    end

    test "status win is false", context do
      assert Status.win?(context[:nearly_full_board]) == false
    end

    test "status tie is false", context do
      assert Status.tie(context[:nearly_full_board]) == false
    end

    test "status over is false", context do
      assert Status.over(context[:nearly_full_board]) == :game_in_progress
    end
  end

  describe "when player \"X\" has won" do
    setup do
      %{
        x_winning_board: %{
          {0, 0} => "X",
          {0, 1} => "O",
          {0, 2} => "X",
          {1, 0} => "O",
          {1, 1} => "X",
          {1, 2} => "O",
          {2, 0} => "X",
          {2, 1} => "O",
          {2, 2} => "O"
        }
      }
    end

    test "status win is true", context do
      assert Status.win?(context[:x_winning_board]) == true
    end

    test "status tie is false", context do
      assert Status.tie(context[:x_winning_board]) == false
    end

    test "status over is true", context do
      assert Status.over(context[:x_winning_board]) == :game_over
    end

    test "winning path is found", context do
      assert Status.winning_path(context[:x_winning_board]) == [[{2, 0}, {1, 1}, {0, 2}]]
    end

    test "winner is \"X\"", context do
      assert Status.winner(context[:x_winning_board]) == "X"
    end
  end

  describe "when player \"O\" has won" do
    setup do
      %{
        o_winning_board: %{
          {0, 0} => "O",
          {0, 1} => "X",
          {0, 2} => "O",
          {1, 0} => "X",
          {1, 1} => "O",
          {1, 2} => "X",
          {2, 0} => "O",
          {2, 1} => "X",
          {2, 2} => "X"
        }
      }
    end

    test "status win is true", context do
      assert Status.win?(context[:o_winning_board]) == true
    end

    test "status tie is false", context do
      assert Status.tie(context[:o_winning_board]) == false
    end

    test "status over is true", context do
      assert Status.over(context[:o_winning_board]) == :game_over
    end

    test "winning path is found", context do
      assert Status.winning_path(context[:o_winning_board]) == [[{2, 0}, {1, 1}, {0, 2}]]
    end

    test "winner is \"O\"", context do
      assert Status.winner(context[:o_winning_board]) == "O"
    end
  end

  describe "when game is a tie" do
    setup do
      %{
        tie_board: %{
          {0, 0} => "X",
          {0, 1} => "O",
          {0, 2} => "X",
          {1, 0} => "O",
          {1, 1} => "X",
          {1, 2} => "O",
          {2, 0} => "O",
          {2, 1} => "X",
          {2, 2} => "O"
        }
      }
    end

    test "status win is false", context do
      assert Status.win?(context[:tie_board]) == false
    end

    test "status tie is true", context do
      assert Status.tie(context[:tie_board]) == true
    end

    test "game is over", context do
      assert Status.over(context[:tie_board]) == :game_over
    end
  end
end
