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

  def invert(state) do
    State.get_board(state)
    |> Enum.reduce(%{}, fn {k, vs}, acc ->
      Map.update(acc, vs, k, &Tuple.append(&1, k))
    end)
  end

  def user_move_to_internal_state(move) do
    try do
      Map.get(
        %{
          1 => {0, 0},
          2 => {0, 1},
          3 => {0, 2},
          4 => {1, 0},
          5 => {1, 1},
          6 => {1, 2},
          7 => {2, 0},
          8 => {2, 1},
          9 => {2, 2}
        },
        move,
        {:error, :nonexistant_space}
      )
    rescue
      ArgumentError -> {:error, :nonexistant_space}
    end
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
