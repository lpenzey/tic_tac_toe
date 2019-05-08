defmodule State do
  defstruct player: "",
            opponent: "",
            current_player: "",
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

  @type t :: %__MODULE__{
          player: String.t(),
          opponent: String.t(),
          current_player: String.t(),
          board: Map.t()
        }

  def get_board(state) do
    state.board
  end

  def get_player(state) do
    state.player
  end

  def get_opponent(state) do
    state.opponent
  end

  def invert(state) do
    State.get_board(state)
    |> Enum.reduce(%{}, fn {k, vs}, acc ->
      Map.update(acc, vs, k, &Tuple.append(&1, k))
    end)
  end

  def set_move(move, state) do
    %State{
      player: state.player,
      opponent: state.opponent,
      board: Map.replace!(state.board, move, state.current_player),
      current_player: switch_player(state)
    }
  end

  def switch_player(state) do
    if state.current_player == state.player do
      state.opponent
    else
      state.player
    end
  end
end
