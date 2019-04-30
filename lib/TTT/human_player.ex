defmodule HumanPlayer do
  def choose_token(deps) do
    token = deps.input.retrieve(:choose_token) |> deps.input.clean() |> String.upcase()

    case token do
      "X" ->
        token

      "O" ->
        token

      _ ->
        choose_token(deps)
    end
  end

  def analyze(move, state, deps) do
    with {:ok, :space_on_board} <- deps.input.space_on_board?(move),
         {:ok, :is_open} <- deps.input.open?(move, state) do
      place_move(move, state)
    else
      {:error, :nonexistant_space} ->
        deps.output.display_message(state, :nonexistant_space)
        deps.input.retrieve(:choose) |> deps.input.sanitized_move() |> analyze(state, deps)

      {:error, :space_taken} ->
        deps.output.display_message(state, :space_taken)
        deps.input.retrieve(:choose) |> deps.input.sanitized_move() |> analyze(state, deps)
    end
  end

  def place_move(move, state) do
    Validation.user_move_to_internal_state(move)
    |> State.set_move(state)
  end
end
