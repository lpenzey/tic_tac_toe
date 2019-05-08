defmodule MinimaxTest do
  use ExUnit.Case

  setup do
    %{
      almost_won_state: %State{
        board: %{
          {0, 0} => "X",
          {0, 1} => "O",
          {0, 2} => "X",
          {1, 0} => "X",
          {1, 1} => "O",
          {1, 2} => "O",
          {2, 0} => 7,
          {2, 1} => 8,
          {2, 2} => "X"
        },
        player: "X",
        opponent: "O",
        current_player: "O"
      }
    }
  end

  test "score win by human player", context do
    assert Minimax.score_move(context[:almost_won_state], "X") == %{score: -10}
  end

  test "score win by computer player", context do
    assert Minimax.score_move(context[:almost_won_state], "O") == %{score: 10}
  end

  test "finds winning move from choice of two moves", context do
    assert Minimax.minimax(context[:almost_won_state]).position == {2, 1}
  end

  test "finds winning move from choice of three" do
    three_away_state = %State{
      board: %{
        {0, 0} => "X",
        {0, 1} => 2,
        {0, 2} => "X",
        {1, 0} => "X",
        {1, 1} => "O",
        {1, 2} => "O",
        {2, 0} => 7,
        {2, 1} => "O",
        {2, 2} => 9
      },
      player: "X",
      opponent: "O",
      current_player: "O"
    }

    assert Minimax.minimax(three_away_state).position == {0, 1}
  end

  test "blocks x from winning" do
    four_away_state = %State{
      board: %{
        {0, 0} => "X",
        {0, 1} => 2,
        {0, 2} => "X",
        {1, 0} => 4,
        {1, 1} => "O",
        {1, 2} => 6,
        {2, 0} => 7,
        {2, 1} => 8,
        {2, 2} => 9
      },
      player: "X",
      opponent: "O",
      current_player: "O"
    }

    assert Minimax.minimax(four_away_state).position == {0, 1}
  end

  test "doesn't confuse integers with strings" do
    one_two_symbol_state = %State{
      board: %{
        {0, 0} => 1,
        {0, 1} => 2,
        {0, 2} => 3,
        {1, 0} => "1",
        {1, 1} => "1",
        {1, 2} => "2",
        {2, 0} => "2",
        {2, 1} => 8,
        {2, 2} => "1"
      },
      player: "1",
      opponent: "2",
      current_player: "2"
    }

    assert Minimax.minimax(one_two_symbol_state).position == {0, 0}
  end
end
