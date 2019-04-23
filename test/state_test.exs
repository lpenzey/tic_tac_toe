defmodule StateTest do
  use ExUnit.Case
  doctest State

  setup do
    %{empty_board_state: %State{}}
  end

  test "State struct is created with an empty board", context do
    assert context[:empty_board_state].board == %{
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

  test "State struct is created with player symbol \"X\"", context do
    assert context[:empty_board_state].player == "X"
  end

  test "gets the board values", context do
    assert State.get_board(context[:empty_board_state]) == %{
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

  test "gets the player symbol", context do
    assert State.get_player(context[:empty_board_state]) == "X"
  end

  test "swaps board keys and values", context do
    assert State.invert(context[:empty_board_state]) == %{
             1 => {0, 0},
             2 => {0, 1},
             3 => {0, 2},
             4 => {1, 0},
             5 => {1, 1},
             6 => {1, 2},
             7 => {2, 0},
             8 => {2, 1},
             9 => {2, 2}
           }
  end

  test "can convert move to internal state" do
    assert State.user_move_to_internal_state(1) == {0, 0}
  end

  test "returns nonexistant space error if input is nan" do
    assert State.user_move_to_internal_state("a") ==
             {:error, :nonexistant_space}
  end

  test "identifies input as not matching an existing space" do
    assert State.user_move_to_internal_state("10") ==
             {:error, :nonexistant_space}
  end

  test "switch player symbol from \"X\" to \"O\"", context do
    assert State.switch_player(context[:empty_board_state].player) == "O"
  end

  test "switch player symbol from \"O\" to \"X\"" do
    player_O_state = %State{player: "O"}
    assert State.switch_player(player_O_state.player) == "X"
  end

  test "sets player symbol \"X\" in board and switches player symbol to \"O\"", context do
    move = {0, 0}

    assert State.set_move(move, context[:empty_board_state]) ==
             %State{
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
               player: "O"
             }
  end

  test "sets player symbol \"O\" in board and switches player symbol to \"X\"" do
    empty_board = %State{player: "O"}
    move = {0, 0}

    assert State.set_move(move, empty_board) ==
             %State{
               board: %{
                 {0, 0} => "O",
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
  end
end
