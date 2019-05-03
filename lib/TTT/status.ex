defmodule Status do
  def win?(board) do
    Enum.any?(win_combinations(board), fn winning_combination ->
      Map.take(board, winning_combination)
      |> Map.values()
      |> winning_triplet?
    end)
  end

  def tie(board) do
    if !win?(board) do
      Map.values(board)
      |> Enum.all?(fn spot -> is_binary(spot) end)
    else
      false
    end
  end

  def over(board) do
    cond do
      win?(board) == true ->
        :game_over

      tie(board) == true ->
        :game_over

      win?(board) == false ->
        :game_in_progress

      tie(board) == false ->
        :game_in_progress
    end
  end

  def winner(board) do
    winning_keys =
      winning_path(board)
      |> List.flatten()

    Map.take(board, winning_keys)
    |> Map.values()
    |> Enum.dedup()
    |> List.first()
  end

  def winning_path(board) do
    Enum.filter(win_combinations(board), fn winning_combination ->
      Map.take(board, winning_combination)
      |> Map.values()
      |> winning_triplet?()
    end)
  end

  defp winning_triplet?(["X", "X", "X"]), do: true
  defp winning_triplet?(["O", "O", "O"]), do: true
  defp winning_triplet?(_), do: false

  def win_combinations(board) do
    rows(board) ++ columns(board) ++ diagonals(board)
  end

  defp board_dimension(board) do
    map_size(board)
    |> :math.sqrt()
    |> round()
  end

  defp rows(board) do
    Map.keys(board)
    |> Enum.chunk_every(board_dimension(board))
  end

  defp columns(board) do
    rows(board)
    |> List.zip()
    |> Enum.map(&Tuple.to_list/1)
  end

  defp diagonals(board) do
    [first_diagonal(board) | [second_diagonal(board)]]
  end

  defp first_diagonal(board) do
    rows(board)
    |> Enum.with_index()
    |> Enum.map(fn {row, index} -> Enum.at(row, index) end)
  end

  defp second_diagonal(board) do
    rows(board)
    |> Enum.reverse()
    |> Enum.with_index()
    |> Enum.map(fn {row, index} -> Enum.at(row, index) end)
  end
end
