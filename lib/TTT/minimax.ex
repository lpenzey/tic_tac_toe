defmodule Minimax do
  def minimax(state) do
    with :game_over <- Status.over(State.get_board(state)) do
      score_move(state, Status.winner(state.board))
    else
      :game_in_progress ->
        available_moves = Map.keys(Player.available_moves(state))

        scored_moves =
          Enum.map(available_moves, fn position ->
            new_state = Player.place_move(position, state)

            %{
              position: position,
              score: minimax(new_state).score
            }
          end)

        optimal_move(scored_moves, state)
    end
  end

  def score_move(state, winner) do
    cond do
      state.player == winner ->
        %{score: -20}

      state.opponent == winner ->
        %{score: 20}

      nil == winner ->
        %{score: 0}
    end
  end

  def optimal_move(moves, state) do
    min = state.player
    max = state.opponent
    current = state.current_player

    case current do
      ^max ->
        Enum.reduce(moves, %{position: nil, score: -10}, fn move, acc ->
          if move.score > acc.score do
            move
          else
            acc
          end
        end)

      ^min ->
        Enum.reduce(moves, %{position: nil, score: 10}, fn move, acc ->
          if move.score < acc.score do
            move
          else
            acc
          end
        end)
    end
  end
end
