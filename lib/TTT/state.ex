defmodule State do
  defstruct player: "X",
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
            }

  @type t :: %__MODULE__{player: String.t(), board: Map.t()}

  def get_board(state) do
    state.board
  end

  def get_player(state) do
    state.player
  end

  def set_move(move, state) do
    %State{
      player: switch_player(state.player),
      board: Map.replace!(state.board, move, state.player)
    }
  end

  def switch_player("X"), do: "O"

  def switch_player("O"), do: "X"
end
